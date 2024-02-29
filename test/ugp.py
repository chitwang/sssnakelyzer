## Hyperparams
LR = 0.00005
MAX_EPOCH = 4
BATCH_SIZE = 2048
outpath = '../models/'
drop_probability = 0.000001
###########################

class SineLayer(nn.Module):
    def __init__(self, in_features, out_features, bias=True, is_first=False, omega_0=30):
        super().__init__()
        self.omega_0 = omega_0
        self.is_first = is_first

        self.in_features = in_features
        self.linear = nn.Linear(in_features, out_features, bias=bias)

        self.init_weights()

    def init_weights(self):
        if torch.no_grad():
            if self.is_first:
                self.linear.weight.uniform_(-1 / self.in_features,
                                             1 / self.in_features)
            else:
                self.linear.weight.uniform_(-np.sqrt(6 / self.in_features) / self.omega_0,
                                             np.sqrt(6 / self.in_features) / self.omega_0)


    def forward(self, x):
        return torch.sin(self.omega_0 * self.linear(x))


## Add dropout layer
class ResidualSineLayerDropout(nn.Module):
    def __init__(self, features, bias=True, ave_first=False, ave_second=False, omega_0=30, dropout_val=0.0001):
        super().__init__()
        self.omega_0 = omega_0

        self.features = features
        self.linear_1 = nn.Linear(features, features, bias=bias)
        self.linear_2 = nn.Linear(features, features, bias=bias)
        self.weight_1 = .5 if ave_first else 1
        self.weight_2 = .5 if ave_second else 1

        #Define proportion of neurons to dropout
        self.dropout = nn.Dropout(dropout_val)

        self.init_weights()


    def init_weights(self):
        if torch.no_grad():
            self.linear_1.weight.uniform_(-np.sqrt(6 / self.features) / self.omega_0,
                                           np.sqrt(6 / self.features) / self.omega_0)
            self.linear_2.weight.uniform_(-np.sqrt(6 / self.features) / self.omega_0,
                                           np.sqrt(6 / self.features) / self.omega_0)

    ## Version 2
    def forward(self, input):
        sine_1 = self.omega_0 * self.linear_1(self.weight_1*input)
        sine_1 = torch.sin(sine_1)
        #sine_1 = self.dropout(sine_1)
        sine_2 = self.omega_0 * self.linear_2(sine_1)
        sine_2 = torch.sin(sine_2)
        sine_2 = self.dropout(sine_2)
        return self.weight_2*(input+sine_2)


## Main Residual Siren Network
class MyResidualSirenNet(nn.Module):
    def __init__(self, dropout_val=0.0001):
        super(MyResidualSirenNet, self).__init__()

        self.Omega_0=30
        self.n_layers = 6
        self.input_dim = 3
        self.output_dim = 1
        self.neurons_per_layer = 50
        self.dropout = dropout_val
        self.layers = [self.input_dim, self.neurons_per_layer, 
                        self.neurons_per_layer, self.neurons_per_layer, 
                        self.neurons_per_layer, self.neurons_per_layer, 
                        self.output_dim]
        
        self.net_layers = nn.ModuleList()
        for idx in np.arange(self.n_layers):
            layer_in = self.layers[idx]
            layer_out = self.layers[idx+1]

            ## if not the final layer
            if idx != self.n_layers-1:
                ## if first layer
                if idx==0:
                    self.net_layers.append(SineLayer(layer_in,layer_out,bias=True,is_first=idx==0))
                ## if an intermdeiate layer
                else:
                    self.net_layers.append(ResidualSineLayerDropout(layer_in,bias=True,ave_first=idx>1,ave_second=idx==(self.n_layers-2), dropout_val=self.dropout))
            ## if final layer
            else:
                final_linear = nn.Linear(layer_in,layer_out)
                ## initialize weights for the final layer
                if torch.no_grad():
                    final_linear.weight.uniform_(-np.sqrt(6 / (layer_in)) / self.Omega_0, np.sqrt(6 / (layer_in)) / self.Omega_0)
                self.net_layers.append(final_linear)

    def forward(self,x):
        for idx,net_layer in enumerate(self.net_layers):
            x = net_layer(x)
        return x

########################
device = torch.device("cuda") if torch.cuda.is_available() else torch.device("cpu")

model = MyResidualSirenNet(dropout_val=drop_probability).to(device)
print(model)
optimizer = optim.Adam(model.parameters(), lr=LR)
criterion = nn.MSELoss()

input_data_file = './sample_data/Pf25.binLE.raw_corrected_2_subsampled.vti'

reader = vtk.vtkXMLImageDataReader()
reader.SetFileName(input_data_file)
reader.Update()

data = reader.GetOutput()
num_pts = data.GetNumberOfPoints()
dims = data.GetDimensions()

data_arr = data.GetPointData().GetArray(0)

np_arr_coord = np.zeros((num_pts,3))
np_arr_vals = np.zeros((num_pts,1))

for i in range(num_pts):
    pt = data.GetPoint(i)
    val1 = data_arr.GetTuple1(i)
    np_arr_vals[i,:] = val1
    np_arr_coord[i,:] = pt

## Normalize between -1 to 1
min_data = np.min(np_arr_vals[:,0])
max_data = np.max(np_arr_vals[:,0])
np_arr_vals[:,0] = 2.0*((np_arr_vals[:,0]-min_data)/(max_data-min_data)-0.5)


### Normalize between 0 to 1
np_arr_coord[:,0] = np_arr_coord[:,0]/dims[0]
np_arr_coord[:,1] = np_arr_coord[:,1]/dims[1]
np_arr_coord[:,2] = np_arr_coord[:,2]/dims[2]


## convert to torch tensor
torch_coords = torch.from_numpy(np_arr_coord)
torch_vals = torch.from_numpy(np_arr_vals)

train_dataloader = DataLoader(TensorDataset(torch_coords, torch_vals), batch_size=BATCH_SIZE,
                              pin_memory=True, shuffle=True)


#################################################
print('Data setup is complete, now starting training...')

train_loss_list = li
for epoch in range(MAX_EPOCH+1):

    model.train()

    temp_loss_list = li
    for X_train, y_train in train_dataloader:
        X_train = X_train.type(torch.float32).to(device)
        y_train = y_train.type(torch.float32).to(device)

        optimizer.zero_grad()
        predictions = model(X_train)

        loss = criterion(predictions,y_train)
        loss.backward()
        optimizer.step()

        temp_loss_list.append(loss.detach().cpu().numpy())

    train_loss_list.append(np.average(temp_loss_list))

    print("epoch: ",epoch," train loss: ", train_loss_list[-1])


    #if epoch%50==0 or epoch==MAX_EPOCH:
    ## save model
    torch.save({"epoch": epoch + 1,
                "model_state_dict": model.state_dict()},
                os.path.join(outpath + 'vol_uncert_chk_' + str(epoch) + '.pth'))
    
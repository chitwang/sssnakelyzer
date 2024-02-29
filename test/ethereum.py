'''
Copyright (C) 2022, Authors: Tanmay Thapliyal, Rachit Agarwal,  Deepesh Chaudhari
Contact: {tanmayt, rachitag, deepeshc}@iitk.ac.in
'''





def write_pkl(file,pklfile):
    with open(file,'wb') as infile:
        pickle.dump(pklfile,infile)
    infile.close()
    print('written')

def read_pkl(filepath):
    with open(filepath, 'rb') as outfile:
        File = pickle.load(outfile)
    return File

def addNodePropertiesStructure():
    '''
    add properties to a node
    returns: a dictionary of properties that will be added to a node. Currently the structure looks like
    prop={'indegree':{},'outdegree':{},'degree':{},
        'indegreeTimeInv':0,'outdegreeTimeInv':0,'degreeTimeInv':0,
        'numberOfburstTemporalInOut':0,'longestBurstTemporalInOut':0,
        'numberOfburstTemporalIn':0,'longestBurstTemporalIn':0,
        'numberOfburstTemporalOut':0,'longestBurstTemporalOut':0,
        'numberOfburstDegreeInOut':0,'longestBurstDegreeInOutAtTime':0,
        'numberOfburstDegreeIn':0,'longestBurstDegreeInAtTime':0,
        'numberOfburstDegreeOut':0,'longestBurstDegreeOutAtTime':0,
        'zeroTransactions':0,
        'balanceIn':{},'balanceOut':{}, 'totalBal':0,
        'gasPrice':{}, 
        'transactedFirst':0,
        'transactedLast':0,
        'activeDuration':0,
        'maxInPayment':{},
        'maxOutPayment':{},
        'freqMaxInPayment':{},
        'freqMaxOutPayment':{},
        'freqBalanceInMoreTheta':{},
        'freqBalanceOutMoreTheta':{},
        'averagePerInBal':0,
        'uniqueIn':0,
        'lastActiveSince':0,
        'attractiveness':{}
    }
    '''
    prop={'indegree':{},'outdegree':{},'degree':{},
        'indegreeTimeInv':0,'outdegreeTimeInv':0,'degreeTimeInv':0,
        'numberOfburstTemporalInOut':0,'longestBurstTemporalInOut':0,
        'numberOfburstTemporalIn':0,'longestBurstTemporalIn':0,
        'numberOfburstTemporalOut':0,'longestBurstTemporalOut':0,
        'numberOfburstDegreeInOut':0,'longestBurstDegreeInOutAtTime':0,
        'numberOfburstDegreeIn':0,'longestBurstDegreeInAtTime':0,
        'numberOfburstDegreeOut':0,'longestBurstDegreeOutAtTime':0,
        'zeroTransactions':0,
        'balanceIn':{},'balanceOut':{}, 'totalBal':0,
        'gasPrice':{}, 
        'transactedFirst':0,
        'transactedLast':0,
        'activeDuration':0,
        'maxInPayment':{},
        'maxOutPayment':{},
        'freqMaxInPayment':{},
        'freqMaxOutPayment':{},
        'freqBalanceInMoreTheta':{},
        'freqBalanceOutMoreTheta':{},
        'averagePerInBal':0,
        'uniqueIn':0,
        'lastActiveSince':0,
        'attractiveness':{}
    }
    return prop

def temporalNodeProperties(txn, nodes, nodeProp,temporalNeighbours):
    

    block_number = str(txn['blockNumber'])
    value = int(txn['value'])
    value = float(value/10**18) #converting to ethers
    
    sender = txn['from'].lower()
    receiver = txn['to'].lower()
        
    if sender not in nodeProp:
        nodeProp[sender]=addNodePropertiesStructure()

    #setting other node properties

    #a sender can send ethers to many other accounts. 
    #so for that particular instance how much is sent has to be added.
    if block_number in nodeProp[sender]['balanceOut']:
        nodeProp[sender]['balanceOut'][block_number].append(value)
    else:
        nodeProp[sender]['balanceOut'][block_number]=[value]


    gasPrice=int(txn['gasPrice'])
    gasPrice = math.ceil(gasPrice/(10**9))

    if gasPrice>0:
        #same as balanceOut
        if block_number in nodeProp[sender]['gasPrice']:
            nodeProp[sender]["gasPrice"][block_number].append(gasPrice)
        else:
            nodeProp[sender]["gasPrice"][block_number]=[gasPrice]
        
    if receiver not in nodeProp:
        
        temporalNeighbours[receiver]={}
        temporalNeighbours[receiver][block_number]={sender}
        nodeProp[receiver]=addNodePropertiesStructure()
    else:
        if receiver not in temporalNeighbours:
            temporalNeighbours[receiver]={}
        if block_number not in temporalNeighbours[receiver]:
            temporalNeighbours[receiver][block_number]={sender}
        else:
            temporalNeighbours[receiver][block_number].add(sender)
    

    #same as balanceOut
    if block_number in nodeProp[receiver]['balanceIn']:
        nodeProp[receiver]['balanceIn'][block_number].append(value)
    else:
        nodeProp[receiver]['balanceIn'][block_number] = [value]

    return nodes,nodeProp,temporalNeighbours

    
def whenNodeObserved(transactions,nodes={},nodeProp={},temporalNeighbours={},uniqueTimes={0},date = ''):
    '''
    not using graphs for specific reason (graphs are expensive DS). graph is only used to create aggretated graphs for clustering coeff. see graphBased.py

    it reads the transcation files specified in inputTransactionFiles 

    input:     inputTransactionFiles: name of json file to read transcations from
            (default={}) nodeProp: a dictionary with keys (users) and values (properties). For which propeties see addNodePropertiesStructure()
            (default={}) nodes: dictionary where keys (users) have 2 lists. list one specifies times when it acts as a sender and another when it acts as receiver
            (default={}) temporalNeighbors: dictionary where keys (users) have a value which is a dictionary. The disctionary has key (time) and value as a Set of neighbors.
            (default={0}) uniqueTimes: Set of unique time observed.
            the defaults are set because there can be multiple files from where it has to read transcations
    returns: nodeProperties: a dictionary with keys (users) and values (properties)
            nodes: dictionary where keys (users) have 2 lists. list one specifies times when it acts as a sender and another when it acts as receiver
            temporalNeighbors: dictionary where keys (users) have a value which is a dictionary. The disctionary has key (time) and value as a Set of neighbors.
            uniqueTimes: Set of unique time observed.
    '''

    for Hash in tqdm(transactions.index.values):
        
        txn = {}
        txn['blockNumber'] = transactions.at[Hash,'block_number']
        txn['value'] = transactions.at[Hash,'value']
        txn['gasPrice'] = transactions.at[Hash,'gas_price']
        txn['from'] = transactions.at[Hash,'from_address']
        txn['to'] = transactions.at[Hash,'to_address']
        
        try:
            block_number = str(txn['blockNumber'])
            nodes['1D'][date],nodeProp['1D'][date],temporalNeighbours['1D'][date]=temporalNodeProperties(txn,nodes['1D'][date],nodeProp['1D'][date],temporalNeighbours['1D'][date])
            
        except Exception as e:
    
            print('Exception occured is',str(e),type(e))
            break
            

    return nodes, nodeProp, temporalNeighbours, uniqueTimes

def nodeProperties(nodes,nodeProp,lastTime,temporalNeighbours):
    '''
    Set all Node's infered properties
    input: nodeProp: a dictionary with keys (users) and values (properties)
        nodes: dictionary where keys (users) have 2 lists. list one specifies times when it acts as a sender and another when it acts as receiver
        temporalNeighbors: dictionary where keys (users) have a value which is a dictionary. The disctionary has key (time) and value as a Set of neighbors.
        timesIDs: Set of unique time observed.
    returns: Populated nodeProp
    '''

    count=1
    print ("number of nodes ",str(len(nodes)))
    for i in nodes:

        count+=1
        
        #identifying temporal burst
        nodeProp[i]['numberOfburstTemporalInOut'],nodeProp[i]['longestBurstTemporalInOut'],nodeProp[i]['numberOfburstTemporalIn'],nodeProp[i]['longestBurstTemporalIn'],nodeProp[i]['numberOfburstTemporalOut'],nodeProp[i]['longestBurstTemporalOut'],nodeProp[i]['lastActiveSince']=temporalBurstiness(nodes[i],lastTime,thetaInOut=1, thetaIn=1, thetaOut=1)
        #identifying degree burst
        nodeProp[i]['numberOfburstDegreeInOut'],nodeProp[i]['longestBurstDegreeInOutAtTime'],nodeProp[i]['numberOfburstDegreeIn'],nodeProp[i]['longestBurstDegreeInAtTime'],nodeProp[i]['numberOfburstDegreeOut'],nodeProp[i]['longestBurstDegreeOutAtTime']=degreeBurstiness(nodeProp[i]['degree'],nodeProp[i]['outdegree'],nodeProp[i]['indegree'],thetaInOut=1, thetaIn=1, thetaOut=1)
        


        #setting attractiveness
        if (len(nodes[i][1])!=0):
            try:
                print("calculating attr")
                nodeProp[i]['attractiveness'],nodeProp[i]['uniqueIn']=nodeAttractiveness(temporalNeighbours[i])
            except Exception as e:
                print(str(e),i,nodes[i][1],temporalNeighbours[i])
            
    return nodeProp



def preprocessEthereumData(date = ''):
    '''
    preprocess ethereum data and create required node files
    input args
    '''
    transactions = read_pkl('./backend/transactions.pkl')
    timeIDsSet={0}
    nNodeObserved={'1D':{}}#'1M':{}}#,'1D':{},'6M':{},'1Y':{},
#                    'All':{}}
#     nNodeObserved={date:{}}
    nodeObserved={}
    nTemporalNeighbours={'1D':{}}#'1M':{}}#,'1D':{},'6M':{},'1Y':{},
                         #'All':{}}
#     nTemporalNeighbours= {date:{}}
    temporalNeighbours={}
    nNodeProp={'1D':{}}#'1M':{}}#,'1D':{},'6M':{},'1Y':{},
               #'All':{}}
#     nNodeProp={date:{}}
    nodeProp={}

#     for DayIndex in range(0,2470):#1531):
    nNodeObserved['1D'][date]={}
    nTemporalNeighbours['1D'][date]={}
    nNodeProp['1D'][date]={}
  
    nNodeObserved,nNodeProp,nTemporalNeighbours, timeIDsSet = whenNodeObserved(transactions,nodes=nNodeObserved,nodeProp=nNodeProp,
        temporalNeighbours=nTemporalNeighbours, uniqueTimes=timeIDsSet,date = date)
        
    print("completed reading all the files")
    print("savingfiles")
    
    del nNodeObserved
    with open('./backend/nodeProperties_test.pkl','wb') as outfile:
        pickle.dump(nNodeProp, file=outfile)
    outfile.close()
    del nNodeProp
    with open('./backend/temporalneighborNodes_test.pkl','wb') as outfile:
        pickle.dump(nTemporalNeighbours, file=outfile)
    outfile.close()
    
    del nTemporalNeighbours
    del timeIDsSet
    print("savedFiles")

# helper functions
def countMoreThanTheta(inWhat,theta=0.0):
    '''
    Returns Dict[keys such that value of key>theta]
    input inwhat: dictionary
        theta: int/float threshold to compare with
    '''
    freq = {}
    for item in inWhat: 
        if inWhat[item]>theta:
            if item in freq:
                freq[item] += 1
            else: 
                freq[item] = 1
    return freq

def countMoreThanThetaInList(inWhat,theta=0.0):  
    '''
    Returns Dict[keys such that value of key>theta]
    input inwhat: list
        theta: int/float threshold to compare with
    '''
    count=0
    for item in inWhat: 
        if item>theta:
            count += 1
    return count

def countFrequencySingle(bal):  
    '''
    Returns a frequency Dictionary of timestamp and its occurance
    input: timeListOfNodes: list of times when the node acts as sender or receiver or both
    return: timeFrequency: dictionary of timestaps with its frequency of occurance
    '''
    timeFrequency = {} 
    for item in bal.keys(): 
        timeFrequency[item] = len(bal[item])
    return timeFrequency

def countFrequency(inBal,outBal):
    '''
    Returns a frequency Dictionary of timestamp and its occurance
    input: timeListOfNodes: list of times when the node acts as sender or receiver or both
    return: timeFrequency: dictionary of timestaps with its frequency of occurance
    '''
    timeFrequency = {} 
    for item in inBal.keys(): 
        timeFrequency[item] = len(inBal[item])
    for item in outBal.keys():
        if item in timeFrequency:
            timeFrequency[item] += len(outBal[item])
        else:
            timeFrequency[item] = len(outBal[item])
    return timeFrequency

def interEventTimeDouble(bal,transactedFirst):  
    '''
    '''
    ietime = []
    listtemp=sorted(bal.keys())
    temp = transactedFirst
    for i in range(1,len(listtemp)):
        ietime.append(int(listtemp[i])-int(temp))
        temp=listtemp[i]
    return ietime

def interEventTime(inBal,outBal,transactedFirst):  
    '''
    '''
    ietime = []
   #listtemp=sorted(inBal.keys()+outBal.keys())
    listtemp=list(sorted(list(inBal.keys())+list(outBal.keys())))
    temp=transactedFirst
    for i in range(1,len(listtemp)):
        ietime.append(int(listtemp[i])-int(temp))
        temp=listtemp[i]
    return ietime

def degreeOfNodesTimeVarient(balIn,balOut):
    '''
    input: nodei: node to consider
    Return: outdegree, indegree and degree as dictionary with timestamp as key and degree-values at that instant
    '''
    outdegree=countFrequencySingle(balOut)
    indegree=countFrequencySingle(balIn)
    degree=countFrequency(balOut,balIn)
    return degree,outdegree,indegree


def nodeAttractiveness(temporalNeighborsOfNode):
    '''
    return node's attraction values 
    input: temporalNeighborsOfNode: a key value pair in the dictionary where keys (users) have a value which is a dictionary. The disctionary has key (time) and value as a Set of neighbors.
    return: attractionValues: dict where key is time and value is the actual value calcualted:
            uniqueIn: number of unique neighbors of the node
    '''
    attractionValues={}
    uniqueIn=0
    validKeys=sorted(list(temporalNeighborsOfNode.keys()))
    if len(validKeys)!=0:
        print(len(validKeys))
        temp=temporalNeighborsOfNode[validKeys[0]]
        attractionValues[validKeys[0]]=0
        #for time in validKeys:
        count=0
        d = 1
        for time in range(1,len(validKeys)):
            #print(time)
            if count%50000==0:
                print(count, end='\r')
            count+=1
            test=temporalNeighborsOfNode[validKeys[time]]
            n=len(temp & test)
            temp=temp|test
            d=len(temp)# | temporalNode[time]) 
            if time in attractionValues:
                print('error in '+str(time))
                print(test)
            else:                
                attractionValues[validKeys[time]]=1-(n/d)
        uniqueIn=d
    else:
        attractionValues[time]=1
        uniqueIn=0
    print("found attr")
    
    return attractionValues,uniqueIn


def degreeBurstiness(degree,outdegree,indegree,thetaInOut=5,thetaIn=5,thetaOut=5):
    '''
    computes based on degree of node
    Uses countMoreThanTheta() to Get bursts in Indegree, Outdegrnodesee and Degree
    Returns number of degree bursts and largest burst in each of them.
    '''
    maxdegreeAt=0
    maxoutdegreeAt=0
    maxindegreeAt=0
    
    degreeburst=countMoreThanTheta(degree,thetaInOut)
    if bool(degreeburst):
        maxdegreeAt=max(degreeburst.items(), key=operator.itemgetter(1))[0]
    
    outdegreeburst=countMoreThanTheta(outdegree,thetaOut)
    if bool(outdegreeburst):
        maxoutdegreeAt=max(outdegreeburst.items(), key=operator.itemgetter(1))[0]
    
    indegreeburst=countMoreThanTheta(indegree,thetaIn)
    if bool(indegreeburst):
        maxindegreeAt=max(indegreeburst.items(), key=operator.itemgetter(1))[0]

    return len(degreeburst.keys()),maxdegreeAt,len(indegreeburst.keys()),maxindegreeAt,len(outdegreeburst.keys()),maxoutdegreeAt


def temporalBurstiness(account,nodeI,lastTime,thetaInOut=1, thetaIn=1, thetaOut=1):
    '''
    computes based on active time/sending time/receiveing time
    Uses getBursts() to find temporal bursts in indegree, outdegree and degree.
    input: nodeI: node to consider from the nodeObserved dict 
        lastTime: last time of the data
        theta: int/float threshold to compare with
    Returns:
         numberOfburstInOut,longestBurstInOut,numberOfburstIn,longestBurstIn,numberOfburstOut,longestBurstOut,activeSince
         (number of temporal bursts and largest burst in each of them and for in case returns active since time).
    '''
    numberOfburstInOut=0
    longestBurstInOut=0
    numberOfburstIn=0
    longestBurstIn=0
    numberOfburstOut=0
    longestBurstOut=0
    activeSince=0
    n0=len(nodeI[0])
    n1=len(nodeI[1])
    nodeI[0] = [int(i) for i in nodeI[0]]
    nodeI[1] = [int(i) for i in nodeI[1]]
    if n0!=0 or n1!=0:#both
        arr=nodeI[0]+nodeI[1]
#         print(nodeI[0]) #debug
        burst,longestBurstInOut,numberOfburstInOut=getBursts(arr,thetaInOut)
    if n0!=0:#sender
        arr=nodeI[0]
        burst,longestBurstOut,numberOfburstOut=getBursts(arr,thetaOut)
    if n1!=0:#receiver
        arr=nodeI[1]
        burst,longestBurstIn,numberOfburstIn=getBursts(arr,thetaIn)
        #For activeSince in the receiver Case
        if bool(burst):
            lastDiff=max(set(burst)) #last burst started at
            lastTimeInLastDiff=sum(burst[lastDiff]) #burst size
            #temp=last bust start+ size
            temp=int(lastTimeInLastDiff)+int(lastDiff)
            if temp==lastTime:
                activeSince=lastDiff
                
    return numberOfburstInOut,longestBurstInOut,numberOfburstIn,longestBurstIn,numberOfburstOut,longestBurstOut,activeSince


def getBursts(observedWhen,theta=1):
    '''
    get Bursts in observedWhen with inter-event time is <=theta
    input: observedWhen: array of Times when a under consideration node is observed
        theta: int/float threshold to compare with
    Return: burst: dict where key is the start time of the burst and value is the list of countinuos times until the burst lasts,
            maxBurstSize: give the size of bust which is longest
            numberOfBurstsWhoseSizeMoreThanTheta: int count of bursts whose size is more than a threshold value
    '''
    burst={}
    observedWhen=sorted(observedWhen)
    counter=observedWhen[0]
    
    for j in range(1,len(observedWhen)):
#         print(j)
        temp=int(observedWhen[j])-int(observedWhen[j-1])
        # temp=1 for continuous send/receive and
        # temp=0 it is possible that sending and receiveing is at same time
        if temp == 1:
            if counter not in burst:
                burst[counter]=[]
            burst[counter].append(1)
        elif temp==0:
            pass
        else:
            counter=observedWhen[j]
            
    maxBurstSize=0 
    numberOfBurstsWhoseSizeMoreThanTheta=0
    for i in burst:
        l=len(burst[i])
        if maxBurstSize<l:
            maxBurstSize=l#longest burst is of l time instance
        if l>theta:
            numberOfBurstsWhoseSizeMoreThanTheta+=1

    return burst, maxBurstSize, numberOfBurstsWhoseSizeMoreThanTheta



def userSpecificTheta(nodesProperties, style=['-','-.','--',':'],theta={}):
    '''
    identify theta for different properties and different temporal data segments. 
    The calculated theta is 80% of the max
    input 
        propertyToCalculate: is the property to find theta for
        nodesProperties: is the entire nodesProperties
        style: is the style in which the line should be plotted.
        theta: dictionary of theta. To access order should be [DataSegment][user][propertyToCalculate]
    output:
        theta: list of theta for property represented by i
    '''
    #erroneous has names of sc's to be checked
    erroneous = set()
    for granularity in nodesProperties.keys():
        if granularity not in theta:
            theta[granularity]={}
        for dataSegment in nodesProperties[granularity].keys():
#             if dataSegment%100==1:
#                 print(dataSegment," Started...")
            if dataSegment not in theta[granularity]:
                theta[granularity][dataSegment]={}

            for user in nodesProperties[granularity][dataSegment]:
                
                theta[granularity][dataSegment][user]={}
                
                balIn=nodesProperties[granularity][dataSegment][user]['balanceIn']
                balOut=nodesProperties[granularity][dataSegment][user]['balanceOut']
                gasPrice=nodesProperties[granularity][dataSegment][user]['gasPrice']
                
                nodesProperties[granularity][dataSegment][user]['degree'],nodesProperties[granularity][dataSegment][user]['outdegree'],nodesProperties[granularity][dataSegment][user]['indegree']=degreeOfNodesTimeVarient(balIn,balOut)
            
                nodesProperties[granularity][dataSegment][user]['degreeTimeInv']=sum(nodesProperties[granularity][dataSegment][user]['degree'].values())
                nodesProperties[granularity][dataSegment][user]['outdegreeTimeInv']=sum(nodesProperties[granularity][dataSegment][user]['outdegree'].values())
                nodesProperties[granularity][dataSegment][user]['indegreeTimeInv']=sum(nodesProperties[granularity][dataSegment][user]['indegree'].values())
                
                keylist=nodesProperties[granularity][dataSegment][user]['degree'].keys()
                try:
                    
                    nodesProperties[granularity][dataSegment][user]['transactedFirst'] = min(keylist)
                except Exception as e:
                    #print('check degree of erroneousSC:',user,'error in min:',e)
                    erroneous.add(user)
                    nodesProperties[granularity][dataSegment][user]['transactedFirst']=0
                try:
                    
                     nodesProperties[granularity][dataSegment][user]['transactedLast']=max(keylist)
                except Exception as e:
                    #print('check degree of account:',user,'error in max:',e)
                    erroneous.add(user)
                    nodesProperties[granularity][dataSegment][user]['transactedLast']=0
                        
                nodesProperties[granularity][dataSegment][user]['activeDuration']=int(nodesProperties[granularity][dataSegment][user]['transactedLast'])-int(nodesProperties[granularity][dataSegment][user]['transactedFirst'])
                
                
                #setting balanceIn
                lx=[]
                lxsum=[]
                if bool(balIn)==True:
                    for j in balIn:
                        li=list(balIn[j])
                        #li=list(balIn[j].values())
                        maxPay=max(li)
                        nodesProperties[granularity][dataSegment][user]["maxInPayment"][j]=maxPay
                        nodesProperties[granularity][dataSegment][user]['freqMaxInPayment'][j]=li.count(maxPay)
                        #nodeProp[i]['freqBalanceInMoreTheta'][j]=countMoreThanThetaInList(li,theta=100.0)
                        nodesProperties[granularity][dataSegment][user]['freqBalanceInMoreTheta'][j]=countMoreThanThetaInList(li,theta=100.0)
                        lx.append(sum(li))
                        lxsum.append(len(li))
                    nodesProperties[granularity][dataSegment][user]["averagePerInBal"] = sum(lx)/float(sum(lxsum))
                    nodesProperties[granularity][dataSegment][user]['totalBal'] += sum(lx)

                #setting balanceOut
                if bool(balOut)==True:
                    for j in balOut:
                        li=list(balOut[j])
                        #li=list(balOut[j].values())
                        maxPay=max(li)
                        nodesProperties[granularity][dataSegment][user]["maxOutPayment"][j] = maxPay
                        nodesProperties[granularity][dataSegment][user]['freqMaxOutPayment'][j]=li.count(maxPay)
                        nodesProperties[granularity][dataSegment][user]['freqBalanceOutMoreTheta'][j]=countMoreThanThetaInList(li,theta=100.0)
                        #nodesProperties[granularity][dataSegment][user]['totalBal'] -= gitsum(li)
                        nodesProperties[granularity][dataSegment][user]['totalBal'] -= sum(li)
                        nodesProperties[granularity][dataSegment][user]['zeroTransactions']+=li.count(0.0)
                
                nodesProperties[granularity][dataSegment][user]['ietimeAll']=interEventTime(balIn,balOut,nodesProperties[granularity][dataSegment][user]['transactedFirst'])
                try:
                    
                    nodesProperties[granularity][dataSegment][user]['ietimeIn']=interEventTimeDouble(balIn,min(balIn.keys()))
                except Exception as e:
                    erroneous.add(user)
                    #print('check degree of account:',user,'error in min ietimeIn:',e)
                    nodesProperties[granularity][dataSegment][user]['ietimeIn']=[]
                
                try:
                    
                    nodesProperties[granularity][dataSegment][user]['ietimeOut'] = interEventTimeDouble(balOut,min(balOut.keys()))
                except Exception as e:
                    erroneous.add(user)
                    #print('check degree of account:',user,'error in max ietimeOut:',e)
                    nodesProperties[granularity][dataSegment][user]['ietimeOut']=[]
                
                
                prop=['indegree','outdegree','degree','maxInPayment','maxOutPayment','gasPrice','balanceIn','balanceOut','ietimeAll', 'ietimeIn','ietimeOut']
                prop2=['gasPrice','balanceIn','balanceOut']
                prop3=['indegree','outdegree','degree','maxInPayment','maxOutPayment']
                prop4=['ietimeAll', 'ietimeIn','ietimeOut']
                for propertyToCalculate in prop:
                    
                    theta[granularity][dataSegment][user][propertyToCalculate]=0
                    
                    #if user not in tempNodeProp:
                    tempTheta=[]
                    #tempTheta.clear()
                    if propertyToCalculate in prop2:
                        for l in nodesProperties[granularity][dataSegment][user][propertyToCalculate].values():
                            for m in l:
                                tempTheta.append(m)
                    elif propertyToCalculate in prop3:
                        tempTheta = list(nodesProperties[granularity][dataSegment][user][propertyToCalculate].values())
                    elif propertyToCalculate in prop4:
                        try:
                            tempTheta = nodesProperties[granularity][dataSegment][user][propertyToCalculate]
                        except Exception as exception:
                            print('user',user,'propertyToCalculate',propertyToCalculate,'Exception',exception)

                    sortedTheta=sorted(tempTheta)
                    
                    if sortedTheta!=[]:
                        #minim=min(sortedTheta)
                        theta[granularity][dataSegment][user][propertyToCalculate]= math.ceil(0.8*(max(sortedTheta)))
                    del(tempTheta)
    return theta,nodesProperties,erroneous

def compute_attractiveness(cores = ''):
    try:
        print('computing attractiveness') #debug
        subprocess.run(['python', './backend/attractiveness.py', '--cores',cores])
        print('attractiveness successfully executed')
    except Exception as e:
        print('Error is',e)
        exit(1)
        
def get_feature_for_one_day(nodeProp = {},date = ''):
    
    predicted_dict = {}
    for account in tqdm(nodeProp['1D'][date].keys()):

        predicted_feature=[]
        for key in nodeProp['1D'][date][account].keys():
            if type(nodeProp['1D'][date][account][key])!=dict:
                continue;
                
            elif len(nodeProp['1D'][date][account][key])<1:
                to_append = 0
                predicted_feature.append(to_append)
                
            else:
                to_pass = list(nodeProp['1D'][date][account][key].values())
                if type(to_pass[0]) == list:
                    temp = []
                    for value in to_pass:
                        temp.append(sum(value))
                    
                    to_append = temp[-1]
                    
#                     print('to_append',to_append)
                    predicted_feature.append(to_append)
    
                else:
            
                    to_append = to_pass[-1]
#                     print('to_append',to_append)
                    predicted_feature.append(to_append)
                    
                        
        predicted_dict[account] = predicted_feature
#         break

    return predicted_dict

def cosine_similarity(a,b):
    cos_sim = dot(a, b)/(norm(a)*norm(b))
    return cos_sim
    
    
def getmaladdresses(data = '',chain = ''):

    dbconn = dbConnections()
    config_obj = config()
    # obj_mongo = query()
    response = dbconn.findAddresses(
                                    query = {"Type":"ETH"},
                                    data={},
                                    database=config_obj.getKey('mongoDBDatabaseName'+chain),
                                    collection=config_obj.getKey('mongoDBCollection'+chain),
                                    chain=chain
                                    )
    malset = set()
    for element in response.keys():
        if len(response[element]['Tag']) != 0:
            malset.add(element)
            
    # print('number of malicious entities being returned:',len(malset)) #debug
    return set(malset).intersection(set(data.keys()))

def getmaliciousness(node_features = {},mals = set(),threshold = 0.999999,date = ''):

    mals = list(mals)
    maldict = {date:{}}
    all_addresses = set(node_features.keys())
    for address in tqdm(all_addresses):
        for maladdress in mals:
            if cosine_similarity(node_features[address],node_features[maladdress])>threshold:
                #record address as mal
                maldict[date][address] = 1
                break;
    return maldict

def format_predictions(data = {}, maliciousdict = {}, date = '2020-12-01'):
    List = []
    for address in tqdm(data.keys()):
        if address not in maliciousdict[date].keys():
            List.append({'name':address,'date':date,'mal':'0'})
        else:
            List.append({'name':address,'date':date,'mal':str(maliciousdict[date][address])})
    return List

def push_predictions_to_mongo(data = {},chain = ''):

    try:
        dbconn = dbConnections()
        configobj = config()
        client = dbconn.connect(chain=chain)
        db = client[configobj.getKey('mongoDBDatabaseName'+chain)]
        # collect = db[configobj.getKey('mongoDBCollectionPredictions'+chain)]
        collect = db['test_ethereum_predictions'] #for testing purposes
        
        for Item in tqdm(data):
            collect.insert_one(Item)
        client.close()
        
    except Exception as e:
        print(traceback.format_exc)()

def run(date = ''):
    
    transactions = read_pkl('./backend/transactions.pkl')
    config_obj = config()

    try:
        preprocessEthereumData(date)
    except Exception as e:
        print('error is',str(e))
        
    nodeProperties = read_pkl('./backend/nodeProperties_test.pkl')
    prop=['indegree','outdegree','degree','gasPrice','maxInPayment','maxOutPayment','balanceIn','balanceOut']
    style=['-','-.','--',':']


    userThetaMinPlus={}
    userThetaMinPlus,nodesProperties,erroneous=userSpecificTheta(nodeProperties, style=style, theta=userThetaMinPlus)
    nodeProp = nodesProperties.copy()
    theta = userThetaMinPlus.copy()

    #add thetaBased Features to nodeProperties
    counter = 0
    for granularity in nodeProp.keys():
        for segment in nodeProp[granularity].keys():
            for account in nodeProp[granularity][segment].keys():
                try:
                    
                    counter+=1
                    #keys(blockNumber) from balanceOut and balanceIn
                    nodeObs = [list(nodeProp[granularity][segment][account]['balanceOut'].keys()),list(nodeProp[granularity][segment][account]['balanceIn'].keys())]
                    #transactedLast for account
                    lasttime = nodeProp[granularity][segment][account]['transactedLast'] 

                    #identifying temporal burst
                    nodeProp[granularity][segment][account]['numberOfburstTemporalInOut'],nodeProp[granularity][segment][account]['longestBurstTemporalInOut'],nodeProp[granularity][segment][account]['numberOfburstTemporalIn'],nodeProp[granularity][segment][account]['longestBurstTemporalIn'],nodeProp[granularity][segment][account]['numberOfburstTemporalOut'],nodeProp[granularity][segment][account]['longestBurstTemporalOut'],nodeProp[granularity][segment][account]['lastActiveSince']=temporalBurstiness(account,nodeObs,lasttime,thetaInOut=theta[granularity][segment][account]['ietimeAll'], thetaIn=theta[granularity][segment][account]['ietimeIn'], thetaOut=theta[granularity][segment][account]['ietimeOut'])
                    
                    #identifying degree burst
                    nodeProp[granularity][segment][account]['numberOfburstDegreeInOut'],nodeProp[granularity][segment][account]['longestBurstDegreeInOutAtTime'],nodeProp[granularity][segment][account]['numberOfburstDegreeIn'],nodeProp[granularity][segment][account]['longestBurstDegreeInAtTime'],nodeProp[granularity][segment][account]['numberOfburstDegreeOut'],nodeProp[granularity][segment][account]['longestBurstDegreeOutAtTime']=degreeBurstiness(nodeProp[granularity][segment][account]['degree'],nodeProp[granularity][segment][account]['outdegree'],nodeProp[granularity][segment][account]['indegree'],thetaInOut=theta[granularity][segment][account]['degree'], thetaIn=theta[granularity][segment][account]['indegree'], thetaOut=theta[granularity][segment][account]['outdegree'])

    #                 if counter%5000 == 0:
    #                     print(counter,'accounts done',end="\r")
                        
                except Exception as e:
                    print('Error',e,'in account',account,'granularity',granularity,'segment',segment)
                    
                    
    countertrans = 0
    for granularity in nodeProp.keys():
        for segment in nodeProp[granularity].keys():
            for account in nodeProp[granularity][segment].keys():
                
                countertrans+=1
                #nodeProp[granularity][segment][account]['balanceBurst'] = 
                a={}
                b={}
                c={}
                
                for blocknumber in nodeProp[granularity][segment][account]['gasPrice']:
                    a[blocknumber] = sum(nodeProp[granularity][segment][account]['gasPrice'][blocknumber])
                    
                for blocknumber in nodeProp[granularity][segment][account]['balanceOut']:
                    b[blocknumber] = sum(nodeProp[granularity][segment][account]['balanceOut'][blocknumber])
                
                for blocknumber in nodeProp[granularity][segment][account]['balanceIn']:
                    c[blocknumber] = sum(nodeProp[granularity][segment][account]['balanceIn'][blocknumber])
                
                nodeProp[granularity][segment][account]['numberOfburstgasPrice'],nodeProp[granularity][segment][account]['longestBurstgasPriceAtTime'],nodeProp[granularity][segment][account]['numberOfburstBalanceOut'],nodeProp[granularity][segment][account]['longestBurstBalanceOutAtTime'],nodeProp[granularity][segment][account]['numberOfburstBalanceIn'],nodeProp[granularity][segment][account]['longestBurstBalanceInAtTime']=degreeBurstiness(a,
                                                                                                        b,
                                                                                                        c,
                                                                                                        thetaInOut=theta[granularity][segment][account]['gasPrice'],
                                                                                                        thetaIn=theta[granularity][segment][account]['balanceOut'], 
                                                                                                        thetaOut=theta[granularity][segment][account]['balanceIn'])
    compute_attractiveness(cores = '6')                                                                                                    
    attr = read_pkl('./backend/attractiveness1D_test.pkl')

    for Dict in attr:
        for keys in Dict.keys():
            nodeProp['1D'][date][keys]['attractiveness'] = Dict[keys]['attractiveness']
    #         nodeProp['1D'][date][keys]['uniqueIn'] = Dict[keys]['uniqueIn']
    node_features = get_feature_for_one_day(nodeProp,date = date)
    malList = getmaladdresses(data = node_features, chain = config_obj.getKey('EnvCft'))
    maldict = getmaliciousness(node_features = node_features,mals = malList, threshold = 0.999999,date = date)
    mal_to_push = format_predictions(data = node_features,maliciousdict=maldict,date = date)
    push_predictions_to_mongo(data = mal_to_push,chain = config_obj.getKey('EnvEth')) #uncomment/comment to push/not push predictions to the mongo server


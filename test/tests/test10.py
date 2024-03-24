class myclass:
    var : int
    x:int = 5
    def func(self):
        self.var = 10
        # print(self.x, self.va)

obj:myclass = myclass()
obj.func()

y:int=8

class Node:
    def __init__(self,v:int):
        self.left:Node\
            = None
        self.right:Node= None
        y:int = 90
    def goof(self):
        print("a",y)
        data = 0
        print("fg",data)
 
def printInorder(root):
    if root:
        printInorder(root.left)
        print(root.data,end=" ")
        printInorder(root.right)

# x:int = 0
x:int = 1e100
print(x)
node = Node(1)
node.goof()
class Node:
    def __init__(self, v:int):
        self.left \
            = None
        self.right = None
        self.data= v
 
def printInorder(root: Node):
    if root:
        printInorder(root.left)
        print(root.data,end=" ")
        printInorder(root.right)

def printPreOrder(node:Node):
    if node is None:
        return
    print(node.data,
           end = " ")
    printPreOrder(node.left)
    printPreOrder(node.right)  

def printPostOrder(node:Node):
    if node is None:
        return
    printPostOrder(node.left)
    printPostOrder(node.right)
    print(node.data, end = " ")

if __name__ == "__main__":
    root = Node(10)
    root.left =\
Node(25)
    root.right = Node(30)
    root.left.left = Node(20)
    root.left.right = Node(35)
    root.right.left = Node(15)
    root.right.right = Node(45)
    print("Inorder Traversal:",end=" ")
    printInorder(root)
    print("\nPreorder Traversal:",
           end=" ")
    printPreOrder(root)
    print("\nPostorder Traversal:", end=" ")
    printPostOrder(root)
    print("\n")

class base:
    x: int

class derived(base):
    y: int
    
    def __init__(self):
        self.x = 5
        self.y += 9*5//4

def main():
    obj: derived = derived()
    obj

__name__ = "ggod"

if __name__ == "main":
    main()



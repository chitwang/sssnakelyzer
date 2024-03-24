class A:
    a: list[int] = [1,2,3]
    b: list[float]
    c: int = 5

class B:
    m_obj: A
    

def main():
    obj: B= B()
    obj.m_obj.a[2]
    # obj.a[3.14]
    # obj.b[10.14]
    # obj.a[obj.a]
    obj.m_obj.a[obj.m_obj.a[0]]
    obj.m_obj.a[obj.m_obj.c]

if __name__ == "main":
    main()

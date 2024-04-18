
class Temp:
  def __init__(self):
    self.a:bool = True

  # def show(self, x:list[int]) -> bool:
  #   return self.a + x[1]


def complicated_flow(num:int):
    if num % 2 == 0:
        print("Even number")
        if num > 10:
            print("Greater than 10")
            if num > 20:
                print("Greater than 20")
            else:
                print("Not greater than 20")
        else:
            print("Not greater than 10")
    elif num % 3 == 0:
        print("Divisible by 3")
        if num > 15:
            print("Greater than 15")
        else:
            print("Not greater than 15")
    else:
        print("Odd number")
        if num < 5:
            print("Less than 5")
        elif num < 10:
            print("Less than 10")
        else:
            print("Greater than or equal to 10")


def complicated_flow11(num:int):
    if num % 2 == 0:
        print("Even number")
        if num > 10:
            print("Greater than 10")
            if num > 20:
                print("Greater than 20")
                if num % 3 == 1:
                    print("Random branch")
                else:
                    print("Another random branch")
            else:
                print("Between 10 and 20")
                if num % 3 == 1:
                    print("Random branch")
                else:
                    print("Another random branch")
        else:
            print("Less than or equal to 10")
            if num > 5:
                print("Greater than 5")
                if num % 3 == 1:
                    print("Random branch")
                else:
                    print("Another random branch")
            elif num == 5:
                print("Equal to 5")
                if num % 3 == 1:
                    print("Random branch")
                else:
                    print("Another random branch")
            else:
                print("Less than 5")
                if num % 3 == 1:
                    print("Random branch")
                else:
                    print("Another random branch")
    else:
        print("Odd number")
        if num % 3 == 0:
            print("Divisible by 3")
            if num > 15:
                print("Greater than 15")
                if num % 3 == 1:
                    print("Random branch")
                else:
                    print("Another random branch")
            elif num == 15:
                print("Equal to 15")
                if num % 3 == 1:
                    print("Random branch")
                else:
                    print("Another random branch")
            else:
                print("Less than 15")
                if num % 3 == 1:
                    print("Random branch")
                else:
                    print("Another random branch")
        else:
            print("Not divisible by 3")
            if num > 20:
                print("Greater than 20")
                if num % 3 == 1:
                    print("Random branch")
                else:
                    print("Another random branch")
            elif num == 20:
                print("Equal to 20")
                if num % 3 == 1:
                    print("Random branch")
                else:
                    print("Another random branch")
            else:
                print("Less than 20")
                if num % 3 == 1:
                    print("Random branch")
                else:
                    print("Another random branch")


def main():
  # li:list[int] = [564, 0, 3]
  obj:Temp = Temp()
  # print(obj.show([1, 2, 3]))

  # if li[1]:
  #   print("IF")
  #   if 0:
  #     print("IF-IF")
  #   elif 1:
  #     print("IF-ELIF")
  #   else:
  #     print("IF-ELSE")
  # elif li[0]:
  #   print("ELIF")
  #   if 0:
  #     print("ELIF-IF")
  #   elif 0:
  #     print("ELIF-ELIF")
  #   else:
  #     print("ELIF-ELSE")
  # else:
  #   print("ELSE")
  #   if 0:
  #     print("ELSE-IF")
  #   elif 1:
  #     print("ELSE-ELIF")
  #   else:
  #     print("ELSE-ELSE")
  # print(obj.show(obj.a))
  i:int
  for i in range(200000):
      complicated_flow11(i)

if __name__ == "__main__":
  main()

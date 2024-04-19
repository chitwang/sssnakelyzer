#various classes
class Vehicle:
    def __init__(self, brand: str):
        self.brand:str = brand

    def start_engine(self) -> None:
        print("The vehicle engine is started.")

    def stop_engine(self) -> None:
        print("The vehicle engine is stopped.")


class Car(Vehicle):
    def __init__(self, brand:str, model:str):
        self.brand = brand
        self.model:str = model

    def drive(self) -> None:
        print("The car is in motion.")

    def park(self) -> None:
        print("The car is parked.")


class ElectricCar(Car):
    def __init__(self, brand:str, model:str, battery_capacity:int):
        self.brand = brand
        self.battery_capacity:int = battery_capacity
        self.model = model

    def charge_battery(self) -> None:
        print("The electric car is charging its kWh battery.")


class Bicycle(Vehicle):
    def __init__(self, brand:str, type_of_bike:str):
        self.brand = brand
        self.type_of_bike:str = type_of_bike

    def pedal(self) -> None:
        print("The bicycle is pedaling.")

    def park(self) -> None:
        print("The bicycle is parked.")


class Motorcycle(Vehicle):
    def __init__(self, brand:str, model:str, engine_type:int):
        self.brand = brand 
        self.model:str = model
        self.engine_type:int = engine_type

    def start_engine(self) -> None:
        print("The motorcycle with a engine is started.")

    def ride(self) -> None:
        print("The motorcycle is on the road.")

    def park(self) -> None:
        print("The motorcycle is parked.")


def main():
    my_electric_car:ElectricCar = ElectricCar("Tesla","Model S", 100)
    my_bicycle:Bicycle = Bicycle("Giant","Mountain")
    my_motorcycle:Motorcycle = Motorcycle("Harley-Davidson","Sportster", 2)

    my_electric_car.start_engine()
    my_electric_car.charge_battery()
    my_electric_car.drive()
    my_electric_car.stop_engine()

    my_bicycle.start_engine()  # Bicycles don't have an engine, but they inherit the method from Vehicle
    my_bicycle.pedal()
    my_bicycle.park()

    my_motorcycle.start_engine()
    my_motorcycle.ride()
    my_motorcycle.park()


if __name__ == "__main__":
    main()

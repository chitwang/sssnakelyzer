#various classes
class Vehicle:
    def __init__(self, brand):
        self.brand = brand

    def start_engine(self):
        print(f"The {self.brand} vehicle engine is started.")

    def stop_engine(self):
        print(f"The {self.brand} vehicle engine is stopped.")


class Car(Vehicle):
    def __init__(self, brand, model):
        super().__init__(brand)
        self.model = model

    def drive(self):
        print(f"The {self.brand} {self.model} car is in motion.")

    def park(self):
        print(f"The {self.brand} {self.model} car is parked.")


class ElectricCar(Car):
    def __init__(self, brand, model, battery_capacity):
        super().__init__(brand, model)
        self.battery_capacity = battery_capacity

    def charge_battery(self):
        print(f"The {self.brand} {self.model} electric car is charging its {self.battery_capacity} kWh battery.")


class Bicycle(Vehicle):
    def __init__(self, brand, type_of_bike):
        super().__init__(brand)
        self.type_of_bike = type_of_bike

    def pedal(self):
        print(f"The {self.brand} {self.type_of_bike} bicycle is pedaling.")

    def park(self):
        print(f"The {self.brand} {self.type_of_bike} bicycle is parked.")


class Motorcycle(Vehicle):
    def __init__(self, brand, model, engine_type):
        super().__init__(brand)
        self.model = model
        self.engine_type = engine_type

    def start_engine(self):
        print(f"The {self.brand} {self.model} motorcycle with a {self.engine_type} engine is started.")

    def ride(self):
        print(f"The {self.brand} {self.model} motorcycle is on the road.")

    def park(self):
        print(f"The {self.brand} {self.model} motorcycle is parked.")


def main():
    my_electric_car = ElectricCar(brand="Tesla", model="Model S", battery_capacity=100)
    my_bicycle = Bicycle(brand="Giant", type_of_bike="Mountain")
    my_motorcycle = Motorcycle(brand="Harley-Davidson", model="Sportster", engine_type="V-twin")

    my_electric_car.start_engine()
    my_electric_car.charge_battery()
    my_electric_car.drive()
    my_electric_car.stop_engine()

    print("\n")

    my_bicycle.start_engine()  # Bicycles don't have an engine, but they inherit the method from Vehicle
    my_bicycle.pedal()
    my_bicycle.park()

    print("\n")

    my_motorcycle.start_engine()
    my_motorcycle.ride()
    my_motorcycle.park()


if __name__ == "__main__":
    main()

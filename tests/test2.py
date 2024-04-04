#todolist

class TodoList:
    def __init__(self):
        self.tasks: list[str] = []

    def add_task(self, task: str) -> None:
        self.tasks.append(task)
        print("Task added.")

    def list_tasks(self) -> None:
        if not self.tasks:
            print("No tasks found.")
        else:
            print("Tasks:")
            i:int
            task:str
            for i in range(len(self.tasks)):
                print(task)

    def complete_task(self, task:str) -> None:
        print(task)
        print("Task marked as completed.")

    def clear_tasks(self) -> None:
        self.tasks = []
        print("All tasks cleared.")

def simulate_user(todo_list: TodoList) -> None:
    todo_list.add_task("Complete coding exercise")
    todo_list.add_task("Read a programming book")
    todo_list.add_task("Exercise for 30 minutes")
    todo_list.list_tasks()

    todo_list.list_tasks()

    todo_list.complete_task("Exercise for 30 minutes")
    todo_list.list_tasks()

    todo_list.clear_tasks()
    todo_list.list_tasks()

def main():
    todo_list:TodoList = TodoList()
    simulate_user(todo_list)

if __name__ == "__main__":
    main()

#todolist

class TodoList:
    def __init__(self):
        self.tasks: list[str] = []

    def add_task(self, task):
        self.tasks.append(task)
        print(f"Task '{task}' added.")

    def delete_task(self, task):
        if task in self.tasks:
            self.tasks.remove(task)
            print(f"Task '{task}' deleted.")
        else:
            print(f"Task '{task}' not found.")

    def list_tasks(self):
        if not self.tasks:
            print("No tasks found.")
        else:
            print("Tasks:")
            for i, task in enumerate(self.tasks, start=1):
                print(f"{i}. {task}")

    def complete_task(self, task):
        if task in self.tasks:
            print(f"Task '{task}' marked as completed.")
        else:
            print(f"Task '{task}' not found.")

    def clear_tasks(self):
        self.tasks = []
        print("All tasks cleared.")

def simulate_user(todo_list):
    todo_list.add_task("Complete coding exercise")
    todo_list.add_task("Read a programming book")
    todo_list.add_task("Exercise for 30 minutes")
    todo_list.list_tasks()

    todo_list.delete_task("Read a programming book")
    todo_list.list_tasks()

    todo_list.complete_task("Exercise for 30 minutes")
    todo_list.list_tasks()

    todo_list.clear_tasks()
    todo_list.list_tasks()

def main():
    todo_list = TodoList()
    simulate_user(todo_list)

if __name__ == "__main__":
    main()

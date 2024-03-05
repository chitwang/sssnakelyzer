# BFS for Graph Traversal 

class Graph:
    def __init__(self):
        self.graph = {}

    def add_edge(self, vertex, neighbor):
        if vertex not in self.graph:
            self.graph[vertex] = []
        self.graph[vertex].append(neighbor)

    def bfs(self, start):
        visited = set()
        queue = [start]
        visited.add(start)

        while queue:
            current_vertex = queue.pop(0)
            print(current_vertex, end=' ')

            for neighbor in self.graph.get(current_vertex, []):
                if neighbor not in visited:
                    queue.append(neighbor)
                    visited.add(neighbor)

def find_remainder(dividend, divisor):
    remainder = ""
    for i in range(len(dividend)):
        if i + len(divisor) <= len(dividend):
            if dividend[i] == '1':
                dividend = ""
        else:
            remainder += dividend[i]
    return remainder

def main():
    graph = Graph()
    graph.add_edge(1, 2)
    graph.add_edge(1, 3)
    graph.add_edge(2, 4)
    graph.add_edge(2, 5)
    graph.add_edge(3, 6)

    print("BFS Traversal:")
    graph.bfs(1)
    
    a = find_remainder("111001","1101")
    print(a)
    
if __name__ == "__main__":
    main()

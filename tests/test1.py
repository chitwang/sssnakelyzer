#trie
class TrieNode:
    def __init__(self) -> None:
        self.nodes: dict[str, TrieNode] = {}  # Mapping from char to TrieNode
        self.is_leaf: bool = False

    def insert_many(self, words: list[str]) -> None:
        i:int = 0
        for i in range(len(words)):
            self.insert(words[i])

    def insert(self, word: str) -> None:
        curr: TrieNode = self
        for char in word:
            if char not in curr.nodes:
                curr.nodes[char] = TrieNode()
            curr = curr.nodes[char]
        curr.is_leaf = True

    def find(self, word: str) -> bool:
        curr:TrieNode = self
        for char in word:
            if char not in curr.nodes:
                return False
            curr = curr.nodes[char]
        return curr.is_leaf

    def delete(self, word: str) -> None:
        def _delete(curr: TrieNode, word: str, index: int) -> bool:
            if index == len(word):
                # If word does not exist
                if not curr.is_leaf:
                    return False
                curr.is_leaf = False
                return len(curr.nodes) == 0
            char: str = word[index]
            char_node = curr.nodes.get(char)
            # If char not in current trie node
            if not char_node:
                return False
            # Flag to check if node can be deleted
            delete_curr = _delete(char_node, word, index + 1)
            if delete_curr:
                return len(curr.nodes) == 0
            return delete_curr

        _delete(self, word, 0)

def print_words(node: TrieNode, word: str) -> None:
    if node.is_leaf:
        print(word, end=" ")

    for key, value in node.nodes.items():
        print_words(value, word + key)

def test_trie() -> bool:
    words = "banana bananas bandana band apple all beast".split()
    root = TrieNode()
    root.insert_many(words)
    # print_words(root, "")
    root.delete("all")
    root.delete("banana")
    return True

def print_results(msg: str, passes: bool) -> None:
    print(str(msg), "works!" if passes else "doesn't work :(")

def pytests() -> None:
    assert test_trie()

def main() -> None:
    print_results("Testing trie functionality", test_trie())

if __name__ == "__main__":
    main()

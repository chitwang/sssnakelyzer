class SegmentTree:
    def __init__(self, array):
        self.array: list[int] = array
        self.size: int = len(array)
        self.tree: list[int] = [0] * (4 * self.size)
        self.lazy: list[int] = [0] * (4 * self.size)

    def _build_tree(self, node: int, start: int, end: int) -> None:
        if start == end:
            self.tree[node] = self.array[start]
        else:
            mid: int = (start + end) // 2
            left_node: int = 2 * node + 1
            right_node: int = 2 * node + 2
            self._build_tree(left_node, start, mid)
            self._build_tree(right_node, mid + 1, end)
            self.tree[node] = self.tree[left_node] + self.tree[right_node]

    def _lazy_propagate(self, node: int, start: int, end: int) -> None:
        if self.lazy[node] != 0:
            self.tree[node] += (end - start + 1) * self.lazy[node]
            if start != end:
                self.lazy[2 * node + 1] += self.lazy[node]
                self.lazy[2 * node + 2] += self.lazy[node]
            self.lazy[node] = 0

    def _range_update(self, node: int, start: int, end: int, left: int, right: int, delta: int) -> None:
        self._lazy_propagate(node, start, end)
        if start > right or end < left:
            return
        if left <= start and end <= right:
            self.tree[node] += (end - start + 1) * delta
            if start != end:
                self.lazy[2 * node + 1] += delta
                self.lazy[2 * node + 2] += delta
            return
        mid: int = (start + end) // 2
        self._range_update(2 * node + 1, start, mid, left, right, delta)
        self._range_update(2 * node + 2, mid + 1, end, left, right, delta)
        self.tree[node] = self.tree[2 * node + 1] + self.tree[2 * node + 2]

    def _range_query(self, node: int, start: int, end: int, left: int, right: int) -> int:
        self._lazy_propagate(node, start, end)
        if start > right or end < left:
            return 0
        if left <= start and end <= right:
            return self.tree[node]
        mid: int = (start + end) // 2
        left_sum: int = self._range_query(2 * node + 1, start, mid, left, right)
        right_sum: int = self._range_query(2 * node + 2, mid + 1, end, left, right)
        return left_sum + right_sum

    def point_update(self, index: int, delta: int) -> None:
        self._range_update(0, 0, self.size - 1, index, index, delta)

    def range_update(self, left: int, right: int, delta: int) -> None:
        self._range_update(0, 0, self.size - 1, left, right, delta)

    def range_query(self, left: int, right: int) -> int:
        return self._range_query(0, 0, self.size - 1, left, right)


if __name__ == "__main__":
    array: list[int] = [1, 3, 5, 7, 9, 11]
    seg_tree: SegmentTree = SegmentTree(array)

    # Build Segment Tree
    seg_tree._build_tree(0, 0, seg_tree.size - 1)
    print("Segment Tree:", seg_tree.tree)

    # Update operations
    seg_tree.point_update(2, 5)
    print("Segment Tree after point update:", seg_tree.tree)

    seg_tree.range_update(1, 4, 2)
    print("Segment Tree after range update:", seg_tree.tree)

    # Query operation
    print("Sum of elements in range [2, 5]:", seg_tree.range_query(2, 5))

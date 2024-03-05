#tic tac toe game
def print_board(board: list[list[str]]) -> None:
    for row in board:
        print("-" * 5)

def dummy()->None:
    a:int = 5
    a = 5 + 6 + 7 + 9
    b: int = 5**7**1
    d: float = 3.0*2.0 + 5 - 7 

def check_winner(board: list[list[str]]) -> str:
    # Check rows
    for row in board:
        if row[0] == row[1] == row[2] != ' ':
            return row[0]
    # Check columns
    for col in range(3):
        if board[0][col] == board[1][col] == board[2][col] != ' ':
            return board[0][col]
    # Check diagonals
    if board[0][0] == board[1][1] == board[2][2] != ' ':
        return board[0][0]
    if board[0][2] == board[1][1] == board[2][0] != ' ':
        return board[0][2]
    return ''

def is_board_full(board: list[list[str]]) -> bool:
    for row in board:
        if ' ' in row:
            return False
    return True

def tic_tac_toe() -> None:
    board: list[list[str]] = [[' ' for _ in range(3)] for _ in range(3)]
    current_player: str = 'X'
    moves = [(0, 0), (1, 1), (2, 2), (0, 2), (1, 1), (2, 0)]
    for row, col in moves:
        board[row][col] = current_player
        winner: str = check_winner(board)
        if winner:
            print_board(board)
            print(f"Player {winner} wins!")
            break
        if is_board_full(board):
            print_board(board)
            print("It's a tie!")
            break
        current_player = 'O' if current_player == 'X' else 'X'
        print_board(board)

def main():
    tic_tac_toe()
    print("Thanks for playing!")

if __name__ == "__main__":
    main()




from ..board import board

board = board()
#block = block()
class Test_Board():

    def test_checkIfBoardIsFull(self):
        board.b[1][25] = 'X'
        assert board.checkIfBoardIsFull() == 1
        board.b[1][25] = ' '
        assert board.checkIfBoardIsFull() == 0
        for i in range(1, board.w-1):
            board.b[2][i] = 'X'
        assert board.checkIfBoardIsFull() == 0
        for i in range(1, board.w-1):
           board.b[1][i] = 'X'
        assert board.checkIfBoardIsFull() == 1
        board.b[28][30] = 'X'
        assert board.checkIfBoardIsFull() == 1
        for i in range(1, board.w-1):
           board.b[1][i] = ' '
        for i in range(1, board.w-1):
           board.b[2][i] = ' '

        
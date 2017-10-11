from ..block import block
from ..gameplay import gameEnv

g = gameEnv()

class Test_Gameplay():

    def test_getNewBlock(self):
        block = g.getNewBlock("X")
        assert block in g.tetrisPieces
        block = g.getNewBlock("X")
        assert block in g.tetrisPieces
        block = g.getNewBlock("X")
        assert block in g.tetrisPieces
        block = g.getNewBlock("X")
        assert block in g.tetrisPieces
        block = g.getNewBlock("X")
        assert block in g.tetrisPieces

    def test_movePiece(self):
        #g.printEnv()
        block = g.tetrisPieces[0]
        new_row,new_col,pieceAtRest = g.movePiece(block,5,6,0,-1)
        assert new_row == 5 and new_col == 5 and pieceAtRest == 0
        new_row,new_col,pieceAtRest = g.movePiece(block,5,1,0,-1)
        assert new_row == 5 and new_col == 1 and pieceAtRest == 1
        block = g.tetrisPieces[3]
        new_row,new_col,pieceAtRest = g.movePiece(block,15,17,0,1)
        assert new_row == 15 and new_col == 18 and pieceAtRest == 0
        block = g.tetrisPieces[5]
        new_row,new_col,pieceAtRest = g.movePiece(block,5,28,0,1)
        assert new_row == 5 and new_col == 28 and pieceAtRest == 1
        g.b[10][20]="X"
        block = g.tetrisPieces[4]
        new_row,new_col,pieceAtBottom = g.movePiece(block,8,20,1,0)
        assert new_row == 8 and new_col == 20 and pieceAtBottom == 1
        block = g.tetrisPieces[6]
        new_row,new_col,pieceAtBottom = g.movePiece(block,8,25,1,0)
        assert new_row == 9 and new_col == 25 and pieceAtBottom == 0

    def test_stageUp(self):
        g.level = 0
        g.score = 200
        time,level = g.stageUp(0.5, g.score, g.level)
        assert time == 0.46 and level == 1
        g.level = 5
        g.score = 100
        time,level = g.stageUp(0.016, g.score, g.level)
        assert time == 0.01 and level == 6
        g.level = 2
        g.score = 1000
        time,level = g.stageUp(0.35, g.score, g.level)
        assert time == 0.14999999999999997 and level == 3
        g.level = 7
        g.score = 350
        time,level = g.stageUp(0.2, g.score, g.level)
        assert time == 0.14 and level == 7
        g.level = 3
        g.score = 10
        time,level = g.stageUp(0.3, g.score, g.level)
        assert time == 0.3 and level == 3

    def test_checkIfRowIsFull(self):
        for i in range(1, g.w-1):
            g.b[5][i]='X'
        assert g.checkIfRowIsFull() == 5
        for i in range(1, g.w-1):
            g.b[3][i]='X'
        assert g.checkIfRowIsFull() == 3
        #g.printEnv()
        g.appendRow(3)
        assert g.checkIfRowIsFull() == 5
        g.appendRow(5)
        assert g.checkIfRowIsFull() == 0
        for i in range(1, g.w-1):
            g.b[29][i]='X'
        assert g.checkIfRowIsFull() == 0
        for i in range(1, g.w-1):
            g.b[15][i] = 'X'
        for i in range(1, g.w-1):
            g.b[8][i] = 'X'
        g.appendRow(g.checkIfRowIsFull())
        assert g.checkIfRowIsFull() == 0

    def test_appendRow(self):
        for i in range(1, g.w-1):
            g.b[29][i] = '-'
        for i in range(1, g.w-1):
            g.b[25][i]='X'
        g.b[24][5] = 'X'
        g.b[24][12] = 'X'
        g.b[24][7] = 'X'
        g.b[1][7] = 'X'
        g.b[1][4] = 'X'
        g.appendRow(25)
        assert g.b[25][5] == 'X'
        assert g.b[25][12] == 'X'
        assert g.b[25][7] == 'X'
        assert g.b[1][7] == ' '
        assert g.b[1][4] == ' '

    def test_scoreUpdate(self):
        g.score = 130
        g.scoreupdate(20)
        assert g.score == 150
        g.scoreupdate(0)
        assert g.score == 150
        g.scoreupdate(100)
        assert g.score == 250
        g.scoreupdate(35)
        assert g.score == 285
        g.scoreupdate(540)
        assert g.score == 825

    def test_getRandomWall(self):
        for i in range(1, g.h-1):
            for j in range(1, g.w-1):
                g.b[i][j] = ' '
        flag = 0
        g.getrandomwall()
        for i in range(6, g.h-5):
            for j in range(1, g.w-5):
                if g.b[i][j] != ' ':
                    flag = 1
        assert flag == 1
        for i in range(1, g.h-1):
            for j in range(1, g.w-1):
                g.b[i][j] = ' '
        flag = 0
        g.getrandomwall()
        for i in range(6, g.h-5):
            for j in range(1, g.w-5):
                if g.b[i][j] != ' ':
                    flag = 1
        assert flag == 1
        for i in range(1, g.h-1):
            for j in range(1, g.w-1):
                g.b[i][j] = ' '
        flag = 0
        g.getrandomwall()
        for i in range(6, g.h-5):
            for j in range(1, g.w-5):
                if g.b[i][j] != ' ':
                    flag = 1
        assert flag == 1

        

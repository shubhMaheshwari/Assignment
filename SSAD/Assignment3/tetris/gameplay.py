from random import randint
from block import *
from board import *
import time
import select
import sys
import os


class gameEnv(block,board):                                                     # gameEnv class inherits from block and board class
    score = 0
    next_move = 0
    curr_block=0
    level = 0

    def instructions(self):                                                     # prints instructions for user regarding controls
        os.system("clear")
        print ""
        print ""
        print ""
        print ""
        print "                        TETRIS"
        print ""
        print "                     Instructions"
        print ""
        print "                 a   ->   move left"
        print "                 d   ->   move right"
        print "                 s   ->   make the block fall"
        print "                 w   ->   rotate block"
        print "                 q   ->   quit"
        print ""
        print "         You need to press ENTER after each keypress"
        print ""
        print "             Enter to continue and q to quit"

    def stageUp(self,time,score,level):                                          # for every level up increases the block fall speed and adds random walls in game
        z = self.score/100
        time = time - z/float(50)
        r = self.score - z*100
        a=[]
        if r == 0 and self.score >= 100:
            self.getrandomwall()
            self.level += 1
        if time > 0:
            time = time
        else:
            time = 0.01
        a.append(time)
        a.append(self.level)
        return a

    def getrandomwall(self):                                                    # for adding random walls on the tetris board
        rrow = randint(6,self.h-6)
        rcol = randint(1,self.w-6)
        for i in range(3):
            for j in range(3):
                rand = randint(1,100)
                rand = rand/float(100)
                if(rand > 0.5):
                    self.b[rrow + i][rcol + j] = 'X'


    def rotateBlock(self,shape,row,col):                                        # rotates the block and returns the new shape
        newshape = []
        newrow = len(shape[0])
        newcol = len(shape)
        for i in range(len(shape)):
            for j in range(len(shape[i])):
                self.b[i+row][j+col] = ' '
        for i in range(newrow):
            newshape.append([])
            for j in range(newcol):
                newshape[i].append(shape[j][i])
        return newshape

    def checkIfRowIsFull(self):                                                 # Returns number of completely filled row
        for i in range(1,self.h-1):
            flag = 1
            for j in range(1,self.w-1):
                if self.b[i][j] == ' ':
                    flag = 0
                    break
            if flag == 1:
                break
        return int(i)*int(flag)

    def appendRow(self,rowToDel):                                               # Removes the filled row and adds an empty row to tetris board
        self.b.pop(rowToDel)
        self.score += 100
        li=[]
        li.append('|')
        for i in range(1,self.w-1):
            li.append(' ')
        li.append('|')
        self.b.insert(1,li)


    def scoreupdate(self,inc):                                                  # updates the score
        self.score += inc
    
    def printEnv(self):                                                         # prints score,tetris board and level
        self.printscore()
        self.printlevel()
        self.printboard()

    def getNewBlock(self,shape):                                                # returns new random block
        self.curr_block = randint(0,6)
        shape = self.tetrisPieces[self.curr_block]
        return shape

    def printscore(self):                                                       # prints score
        print " "
        print "Score : %d" %self.score
        print " "

    def printlevel(self):                                                       # prints level
        print ""
        print "Level : %d" %self.level
        print ""

    def isBoardFull(self):                                                      # checks if first row from top is full or not
        flag = 0;
        for i in range(1,self.w):
            if self.b[1][i] != ' ':
                flag = 1
        return flag

    def EndGame(self):                                                          # Ends the game and prints final score
        print " "
        print " "
        print " "
        print ""
        print "                             Game Over"
        print " "
        print " "
        print "                    Your final score is %d" %self.score
        print " "
        print " "
        print ""
        print " "
        print " "
        print ""
        exit(0)
    
    def movePiece(self,shape,row,col,drow,dcol):                                # Moves the block from row,col to row+drow,col+dcol if possible
        flag = 0
        for i in range(len(shape)):
            for j in range(len(shape[i])):
                if shape[i][j] == 1:
                    self.b[row+i][col+j] = ' '
        row = row + drow
        col = col + dcol
        #print "row is ", row
        #print "col is ", col
        for i in range(len(shape)):
            for j in range(len(shape[i])):
                if shape[i][j] == 1:
                    if self.b[row+i][col+j] != ' ':
                        flag = 1
                        row = row - drow
                        col = col - dcol
                        break
            if flag == 1:
                break
        for i in range(len(shape)):
            for j in range(len(shape[i])):
                if shape[i][j] == 1:
                    self.b[row+i][col+j] = 'X'
        return [row,col,flag]

class engine(gameEnv):                                                          # The game engine class with all the high level logic for game
    
    shape = "X"
    row = 0
    col = 0
    def run(self):
        boardFull = 0
        pieceAtRest = 0
        g = gameEnv()
        g.instructions()
        y = raw_input()
        if y == 'q':
            g.EndGame()
        while boardFull == 0:
            os.system("clear")
            self.shape = g.getNewBlock(self.shape)
            g.scoreupdate(10)
            #print len(self.shape)
            for i in range(len(self.shape)):
                #print len(self.shape[i])
                for j in range(len(self.shape[i])):
                    if self.shape[i][j] == 1:
                        self.b[i+1][self.w/2 - len(self.shape) + j] = "X";
            g.printEnv()
            self.row = 1
            self.col = self.w/2 - len(self.shape)
            pieceAtBottom = 0
            ch = 'p'
            time = 0.35
            time,self.level = g.stageUp(time,self.score,self.level)
            while pieceAtBottom == 0:
                i,o,e = select.select([sys.stdin],[],[],time)
                if(i):
                    x = sys.stdin.readline().strip()
                else:
                    x = 'p'

                if x == 'q':
                    g.EndGame()
                else:
                    if x == 'a':
                        self.row,self.col,pieceAtRest = g.movePiece(self.shape,self.row,self.col,0,-1)
                    elif x == 'd':
                        self.row,self.col,pieceAtRest = g.movePiece(self.shape,self.row,self.col,0,1)
                    elif x == 'p':
                        self.row,self.col,pieceAtBottom = g.movePiece(self.shape,self.row,self.col,1,0)
                    
                    elif x == 'w':
                        self.shape = g.rotateBlock(self.shape,self.row,self.col)
                    elif x == 's':
                        time = 0.001
                    elif x == 'e':
                        g.getrandomwall()

                os.system('clear')
                isRowFull = g.checkIfRowIsFull()
                if isRowFull != 0:
                    g.appendRow(isRowFull)
                g.printEnv()
                isBoardFull = g.checkIfBoardIsFull()
                if isBoardFull == 1:
                    g.EndGame()

if __name__ == "__main__":
    game = engine()
    game.run()

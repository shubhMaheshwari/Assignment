class board(object):
    h = 30
    w = 32
    b = []
    def __init__(self):                     # initializing tetris board
        for i in xrange(self.h):
            self.b.append([])
            for j in xrange(self.w):
                self.b[i].append([])
        for i in xrange(self.h):
            for j in xrange(self.w):
                    self.b[i][j] = " "
        for i in xrange(self.w):
            self.b[0][i] = '-'
            self.b[self.h-1][i] = '-'
        for i in xrange(self.h):
            self.b[i][0] = '|'
            self.b[i][self.w - 1] = '|'

    def printboard(self):                   # prints the tetris board on screen
        for i in xrange(self.h):
            for j in xrange(self.w):
                if j == self.w - 1:
                    print self.b[i][j]
                else:
                    print self.b[i][j],
    
    def checkIfBoardIsFull(self):           # checks if tetris board is full or not , returns 1 if full otherwise returns 0
        flag = 0
        for i in range(1,self.w - 1):
            if self.b[1][i] != ' ':
                flag = 1
                break
        return flag
    
    def instructions(self):                 # implemented in subclass
        raise "NotImplementedError"

    def addLevel(self):                     # test function
        self.b.pop(1)
        li = []
        li.append('|')
        for i in range(1,self.w-1):
            li.append('O')
        li.append('|')
        self.b.insert(self.h-2,li)

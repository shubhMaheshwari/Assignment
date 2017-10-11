
from random import randint


class Person():

    def __init__(self, man, upperPart, lowerPart, x, y):
        self.man = man
        self.upperPart = upperPart
        self.lowerPart = lowerPart
        self.x = x
        self.y = y


class Bomber():

    def __init__(self):
        Person.__init__(self, 'b', "[^^]", " ][ ", 1, 1)


class Enemy1():

    def __init__(self, x, y):
        Person.__init__(self, 'e', " ** ", "||||", x, y)
        self.status = 1


class Enemy2():

    def __init__(self, x, y):
        Person.__init__(self, 'E', " [] ", "/||\\", x, y)
        self.status = 2
        if x % 2 == 0:
            self.dirx = 1
        else:
            self.dirx = 0
        self.diry = 1 - self.dirx


def EnemyArray(board, level, x, y):
    enemy = []

    for _ in range(2 * level):
        a = 0
        b = 0
        while(board[b][a] != ' '):
            a = randint(1, x - 2)
            b = randint(1, y - 2)

        if _ < max(level - 2, 1):
            enemy.append(Enemy1(a, b))
            board[b][a] = 'e'
        else:
            enemy.append(Enemy2(a, b))
            board[b][a] = 'E'

    return enemy

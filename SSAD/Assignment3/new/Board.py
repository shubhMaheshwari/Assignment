import random
import sys
import os
import time
import copy
from Block import Block
from Person import Bomber, Enemy1, Enemy2, EnemyArray
from random import randint
from termcolor import cprint


class Board():

    def __init__(self, x, y, level):
        orignal = [[' ' for j in range(x)] for i in range(y)]
        orignal[0] = ['#'] * x
        orignal[y - 1] = ['#'] * x

        for j in range(1, y - 1):

            if j % 2 == 0:
                horizontallist = []
                for i in range(x):
                    if i % 2 == 0:
                        horizontallist.append('#')
                    else:
                        horizontallist.append(' ')

                orignal[j] = horizontallist
            else:
                orignal[j][0] = '#'
                orignal[j][x - 1] = '#'

        for _ in range(x + y):
            orignal[randint(1, y - 2)][randint(1, x - 2)] = '%'

        self.level = level
        self.x = x
        self.y = y
        self.orignal = orignal
        self.block = Block()
        self.bomber = Bomber()
        self.enemy = EnemyArray(self.orignal, self.level, x, y)

        self.orignal[self.bomber.y][self.bomber.x] = self.bomber.man

    def moveBomber(self, game, dirx, diry):
        x = self.bomber.x
        y = self.bomber.y

        if self.orignal[y + diry][x + dirx] == ' ':
            self.orignal[y][x] = ' '
            self.bomber.x = x + dirx
            self.bomber.y = y + diry

            self.orignal[y + diry][x + dirx] = 'b'

        if self.orignal[y + diry][x + dirx] == 'e':
            game.gameOver()

        if self.orignal[y + diry][x + dirx] == 'E':
            game.gameOver()

    def updateBomb(self, game):
        try:
            game.bomb

            dirx = [0, 0, 0, 1, -1]
            diry = [0, 1, -1, 0, 0]

            if game.bomb.time > 0:
                if self.orignal[game.bomb.y][game.bomb.x] != 'b':
                    self.orignal[game.bomb.y][
                        game.bomb.x] = str(game.bomb.time)
                game.bomb.update()

            elif game.bomb.time == 0:

                game.bomb.time = -1

                points = 0
                for i in range(len(dirx)):
                    if self.orignal[game.bomb.y + diry[i]][game.bomb.x + dirx[i]] == 'b':
                        # print("Killed on first level")
                        game.gameOver()

                    elif self.orignal[game.bomb.y + diry[i]][game.bomb.x + dirx[i]] == '#':
                        pass

                    else:
                        # print("destroyed :",self.orignal[game.bomb.y + diry[i]][game.bomb.x + dirx[i]])
                        if self.orignal[game.bomb.y + diry[i]][game.bomb.x + dirx[i]] == 'e':
                            points = points + 100

                            for ex in self.enemy:
                                # print("ex:",ex.x,ex.y)
                                if ex.x == game.bomb.x + dirx[i] and ex.y == game.bomb.y + diry[i]:
                                    ex.status = 0

                        elif self.orignal[game.bomb.y + diry[i]][game.bomb.x + dirx[i]] == 'E':
                            points = points + 50
                            for ex in self.enemy:
                                # print("ex:",ex.x,ex.y)
                                if ex.x == game.bomb.x + dirx[i] and ex.y == game.bomb.y + diry[i]:
                                    ex.status = 0

                        elif self.orignal[game.bomb.y + diry[i]][game.bomb.x + dirx[i]] == '%':
                            print("Bomb used")
                            points = points + 20

                        self.orignal[game.bomb.y + diry[i]
                                     ][game.bomb.x + dirx[i]] = 'x'

                        if self.orignal[game.bomb.y + 2 * diry[i]][game.bomb.x + 2 * dirx[i]] == 'b':
                            # print("killed on second level")
                            game.gameOver()

                        elif self.orignal[game.bomb.y + 2 * diry[i]][game.bomb.x + 2 * dirx[i]] == '#':
                            pass

                        else:
                            # print("destroyed :",self.orignal[game.bomb.y + 2*diry[i]][game.bomb.x + 2*dirx[i]])

                            if self.orignal[game.bomb.y + 2 * diry[i]][game.bomb.x + 2 * dirx[i]] == 'e':
                                points = points + 100
                                for ex in self.enemy:
                                    if ex.x == game.bomb.x + 2 * dirx[i] and ex.y == game.bomb.y + 2 * diry[i]:
                                        ex.status = 0
                                    else:
                                        pass

                            elif self.orignal[game.bomb.y + 2 * diry[i]][game.bomb.x + 2 * dirx[i]] == 'E':
                                points = points + 50
                                for ex in self.enemy:
                                    if ex.x == game.bomb.x + 2 * dirx[i] and ex.y == game.bomb.y + 2 * diry[i]:
                                        ex.status = 0
                                    else:
                                        pass

                            elif self.orignal[game.bomb.y + 2 * diry[i]][game.bomb.x + 2 * dirx[i]] == '%':
                                points = points + 20
                                print("Bomb used")

                            self.orignal[game.bomb.y + 2 * diry[i]
                                         ][game.bomb.x + 2 * dirx[i]] = 'x'
                return points

            else:
                # print("Erasing bomb :it is at:",game.bomb.x,game.bomb.y)
                self.orignal[game.bomb.y][game.bomb.x] = ' '
                for i in range(len(dirx)):
                    if self.orignal[game.bomb.y + diry[i]][game.bomb.x + dirx[i]] != '#':

                        self.orignal[game.bomb.y + diry[i]
                                     ][game.bomb.x + dirx[i]] = ' '

                        if self.orignal[game.bomb.y + 2 * diry[i]][game.bomb.x + 2 * dirx[i]] != '#':
                            self.orignal[game.bomb.y + 2 * diry[i]
                                         ][game.bomb.x + 2 * dirx[i]] = ' '

                game.bomb = None

        except:
            return 0

    def updateEnemy(self, game):
        for ex in self.enemy:
            if ex.status == 0:
                game.enemiesKilled = game.enemiesKilled + 1
                continue

            elif ex.status == 1:
                x = self.bomber.x
                y = self.bomber.y
                self.orignal[ex.y][ex.x] = ' '
                if y > ex.y:
                    if self.orignal[ex.y + 1][ex.x] == ' ':
                        self.orignal[ex.y + 1][ex.x] = 'e'
                        ex.y = ex.y + 1
                    elif self.orignal[ex.y + 1][ex.x] == 'b':
                        game.gameOver()
                    else:
                        self.orignal[ex.y][ex.x] = 'e'

                elif y < ex.y:
                    if self.orignal[ex.y - 1][ex.x] == ' ':
                        self.orignal[ex.y - 1][ex.x] = 'e'
                        ex.y = ex.y - 1
                    elif self.orignal[ex.y - 1][ex.x] == 'b':
                        game.gameOver()
                    else:
                        self.orignal[ex.y][ex.x] = 'e'

                elif y == ex.y:
                    if x > ex.x:
                        if self.orignal[ex.y][ex.x + 1] == ' ':
                            self.orignal[ex.y][ex.x + 1] = 'e'
                            ex.x = ex.x + 1
                        elif self.orignal[ex.y][ex.x + 1] == 'b':
                            game.gameOver()
                        else:
                            self.orignal[ex.y][ex.x] = 'e'

                    elif x < ex.x:
                        if self.orignal[ex.y][ex.x - 1] == ' ':
                            self.orignal[ex.y][ex.x - 1] = 'e'
                            ex.x = ex.x - 1
                        elif self.orignal[ex.y][ex.x - 1] == 'b':
                            game.gameOver()
                        else:
                            self.orignal[ex.y][ex.x] = 'e'

                    else:
                        game.gameOver()

                else:
                    game.gameOver()

            elif ex.status == 2:
                if ex.diry == 0:
                    if self.orignal[ex.y][ex.x + ex.dirx] == ' ':
                        self.orignal[ex.y][ex.x] = ' '
                        ex.x = ex.x + ex.dirx
                        self.orignal[ex.y][ex.x] = 'E'

                    elif self.orignal[ex.y][ex.x + ex.dirx] == '#' or self.orignal[ex.y][ex.x + ex.dirx] == '%':
                        ex.dirx = -1 * ex.dirx

                    elif self.orignal[ex.y][ex.x + ex.dirx] == 'b':
                        print("Enemy:", ex.x, ex.y)
                        print("Killed the bombers")
                        game.gameOver()

                else:
                    if self.orignal[ex.y + ex.diry][ex.x] == ' ':
                        self.orignal[ex.y][ex.x] = ' '
                        ex.y = ex.y + ex.diry
                        self.orignal[ex.y][ex.x] = 'E'

                    elif self.orignal[ex.y + ex.diry][ex.x] == '#' or self.orignal[ex.y + ex.diry][ex.x] == '%':
                        ex.diry = -1 * ex.diry

                    elif self.orignal[ex.y + ex.diry][ex.x] == 'b':
                        print("Enemy:", ex.x, ex.y)
                        print("Killed the bombers")
                        game.gameOver()

        # print("Killed:",game.enemiesKilled)
        game.enemiesKilled = 0

    def display(self):

        for i in range(self.y):
            for j in range(self.x):
                cprint(self.block.getBlock(self.orignal[i][j], 'Upper'), self.block.getColor(
                    self.orignal[i][j]), end='')
            print('')
            for j in range(self.x):
                cprint(self.block.getBlock(self.orignal[i][j], 'Lower'), self.block.getColor(
                    self.orignal[i][j]), end='')
            print('')

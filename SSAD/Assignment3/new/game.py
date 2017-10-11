from Board import Board
from Bomb import Bomb
from asciiDrawings import instructions, thankyou, trophy
from termcolor import cprint
import random
import sys
import os
import time
import copy
import signal

try:
    import tty
    import termios
except ImportError:
    try:
        import msvcrt
    except ImportError:
        raise ImportError('getch not available')
    else:
        getch = msvcrt.getch
else:
    def getch():
        fd = sys.stdin.fileno()
        old_settings = termios.tcgetattr(fd)
        try:
            tty.setraw(fd)
            ch = sys.stdin.read(1)
        finally:
            termios.tcsetattr(fd, termios.TCSADRAIN, old_settings)
        return ch


def alarmHandler(signum, frame):
    raise AlarmException


class AlarmException(Exception):
    pass


class Game():

    def __init__(self, level):
        self.x = 1
        self.y = 1
        self.level = level
        self.board = Board(19, 19, level)
        self.time = 0
        self.enemiesKilled = 0
        self.bomb = None
        self.GAMEOVER = False

    def input(self, timeout=1):
        signal.signal(signal.SIGALRM, alarmHandler)
        signal.alarm(timeout)

        try:
            inp = getch()
            signal.alarm(0)

            if inp == 'q':
                sys.exit()

            if inp == 'r':
                return 'r'
            if inp == 'p':
                getch()

            x = self.board.bomber.x
            y = self.board.bomber.y
            if inp == 'a':
                self.board.moveBomber(self, -1, 0)

            elif inp == 'w':
                self.board.moveBomber(self, 0, -1)

            elif inp == 's':
                self.board.moveBomber(self, 0, 1)

            elif inp == 'd':
                self.board.moveBomber(self, 1, 0)

            elif inp == 'b':
                if self.bomb == None:
                    self.bomb = Bomb(x, y, 4)

            else:
                pass

            return ''

        except AlarmException:
            signal.signal(signal.SIGALRM, signal.SIG_IGN)
            return ''

    def update(self):
        self.time = self.time + 1
        points = self.board.updateBomb(self)
        self.board.updateEnemy(self)
        os.system("clear")
        return points

    def gameOver(self):
        try:
            os.system("clear")
            self.board.display()
            print("You are dead")
            self.GAMEOVER = True
            print("Press any key to continue")
            getch()
        except:
            print("Error while exiting press q")

    def gameWon(self):
        print("Congrats you won the game")
        trophy()
        game.level = game.level + 1
        getch()

    def scoreboard(self):
        print("		Lives:", end='')
        for _ in range(lives):
            cprint("\u2764 ", 'red', attrs=['bold'], end='')

        enemyCount = 0
        for ex in self.board.enemy:
            if ex.status != 0:
                enemyCount = enemyCount + 1
        print(" 	Enemies:", enemyCount, "		level:", self.board.level)
        print("		SCORE:", points, " 	time:", self.time)
        if enemyCount == 0:
            self.gameWon()

        return enemyCount

if __name__ == "__main__":

    instructions()
    getch()

    points = 0
    lives = 3
    levels = 1
    while lives > 0:
        os.system("clear")
        game = Game(levels)
        while(1):
            # 	for i in game.board.orignal:
            # 		print(i)
            game.board.display()

            if(game.scoreboard() == 0):
                levels = game.level
                break

            time.sleep(0.2)
            if(game.input() == 'r') or (game.GAMEOVER == True):
                break
            try:
                points = points + game.update()
            except:
                pass
        if game.GAMEOVER == True:
            lives = lives - 1

    os.system("clear")
    thankyou()

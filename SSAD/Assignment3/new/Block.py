
class Block():

    def __init__(self):
        self.empty = "    "
        self.wall = "####"
        self.brick = "%%%%"
        self.bombermanUpper = "[^^]"
        self.bombermanLower = " ][ "
        self.enemy1Upper = " ** "
        self.enemy1Lower = "||||"
        self.enemy2Upper = " [] "
        self.enemy2Lower = "/||\\"
        self.bombBlast = "^^^^"

    def getBlock(self, a, b):

        if a == ' ':
            return self.empty

        elif a == '#':
            return self.wall

        elif a == '%':
            return self.brick

        elif a == 'x':
            return self.bombBlast

        elif a == 'b' and b == "Upper":
            return self.bombermanUpper

        elif a == 'b' and b == "Lower":
            return self.bombermanLower

        elif a == 'e' and b == "Upper":
            return self.enemy1Upper

        elif a == 'e' and b == "Lower":
            return self.enemy1Lower

        elif a == 'E' and b == "Upper":
            return self.enemy2Upper

        elif a == 'E' and b == "Lower":
            return self.enemy2Lower

        elif a in ['1', '2', '3', '4']:
            return "[" + a + a + "]"

        else:
            return "errr"

    def getColor(self, a):
        if a == ' ':
            return None

        elif a == '#':
            return 'white'

        elif a == '%':
            return 'yellow'

        elif a == 'x':
            return 'red'

        elif a == 'b':
            return 'blue'

        elif a == 'e':
            return 'green'

        elif a == 'E':
            return 'green'

        elif a in ['1', '2', '3', '4']:
            return 'red'

        else:
            return 'black'

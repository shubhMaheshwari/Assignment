import sys
sys.path.insert(0, './old/')


from random import randint
from Person import Person
from Person import Bomber
from Person import Enemy1
from Person import EnemyArray

# We check whether bomber is a person
def test_Bomber():
	test_bomber = Person('b',"[^^]"," ][ ",1,1)
	assert isinstance(test_bomber, Person)

# We check whether enemy1 is a person
def test_Bomber():
	x = randint(1,100)
	y = randint(1,100)
	test_bomber = Enemy1(x,y)
	assert isinstance(test_bomber, Person)

def test_Bomber():
	test_bomber = Person('b',"[^^]"," ][ ",1,1)
	assert isinstance(test_bomber, Person)		
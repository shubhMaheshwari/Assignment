import numpy as np
board = np.zeros((3,3))

def sym(num):
	if num == 1:
		return 'X'
	elif num == -1:
		return 'O'
	else:
		return ' '			


def play_board(i):

	while(1):		
		x = input('')
		x = int(x)
		
		y = input('')
		y = int(y)
		
		if board[x,y] == 0:
			break

	if (i%2 == 0):
		board[x,y] = 1
	else:	
		board[x,y] = -1

def print_board():
	print('\n  -----------')
	for i in range(3):
		print(' | ',end='')
		for j in range(3):
			print( sym(board[i,j]) + ' | ', end='')
		print('\n  -----------')		

def check_board():
	for i in range(3):
		if (board[i,0] == board[i,1] == board[i,2] != 0):
			return True
	for i in range(3):
		if (board[0,i] == board[1,i] == board[2,i] != 0):
			return True		

	if(board[0,0] == board[1,1] == board[2,2] != 0):
		return True		

	if(board[0,2] == board[1,1] == board[2,0] != 0):
		return True		

	return False	

def start_game():

	i = 0 
	while (i<9):
		print_board()
		try:
			play_board(i)
			i = i +1
			print(check_board())
		except Exception as e:
			print(e)
			continue

	print_board()

if __name__ == '__main__':
	start_game()
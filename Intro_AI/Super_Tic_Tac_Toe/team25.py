import sys
import random
import signal
import time
import copy
	

class Team25():
	# ply is the character x or o
	def __init__(self):
		self.ply = 1 
		self.board = ''	
		self.turn = 0
		self.depth = 8
		self.time = 0
			
		self.reward = 64

		self.cell_weight = [[18,10,10,18],[10,16,16,10],[10,16,16,10],[18,10,10,18]]
		self.dp = {}
		self.condier_possibilites = {}

		self.keys = []
		for i in range(256):
			x = []
			for j in range(3):
				x.append(random.randint(0,1000000))
			self.keys.append(x)

		# Store the value of a state
		self.hash_table = {}
		# Store the depth at which the value is stored
		self.hash_depth = {}

		self.small_keys = []
		for i in range(16):
			x = []
			for j in range(3):
				x.append(random.randint(0,1000000))
			self.small_keys.append(x)

		# Store the value of a state
		self.small_hash_table = {}


		pass


	def create_hash_state(self):
		bs = self.board.board_status
		hash_value = 0
		k = 0
		for i in range(16):
			for j in range(16):
				if bs[i][j] == 'x':
					k = 2
				elif bs[i][j] == 'o':
					k = 1

				elif bs[i][j] == '-':
					k = 0

				hash_value ^= self.keys[16*i + j][k]

		return hash_value

	def calculate_small_hash(self,x,y):
		bs = self.board.board_status
		hash_value = 0
		k = 0
		for i in range(x,x+4):
			for j in range(y,y+4):
				if bs[i][j] == 'x':
					k = 2
				elif bs[i][j] == 'o':
					k = 1

				elif bs[i][j] == '-':
					k = 0

				hash_value ^= self.keys[4*i + j][k]

		return hash_value			

	def find_move_cells(self, old_move):
		#returns the valid cells allowed given the last move and the current board state
		allowed_cells = []
		allowed_block = [old_move[0]%4, old_move[1]%4]
		#checks if the move is a free move or not based on the rules
		bs = self.board

		if old_move != (-1,-1) and bs.block_status[allowed_block[0]][allowed_block[1]] == '-':
			for i in range(4*allowed_block[0], 4*allowed_block[0]+4):
				for j in range(4*allowed_block[1], 4*allowed_block[1]+4):
					if bs.board_status[i][j] == '-':
						allowed_cells.append((i,j))
		else:
			for i in range(4):
				for j in range(4):
					if	bs.block_status[i][j] == '-':
						for k in range(4*i,4*i+4):
							for l in range(4*j,4*j+4):
								if bs.board_status[k][l] == '-' :
									allowed_cells.append((i,j))
		return allowed_cells	
			

	def move(self, board, old_move, flag):
		#You have to implement the move function with the same signature as this
		#Find the list of valid cells allowed
		# print("Allowed moves:",possible_moves)
		
		# Check whether we are X or O
		if flag == 'x':
			self.ply = 1
		elif flag == 'o':
			self.ply = -1

		self.board = copy.deepcopy(board)
		hash_value = self.create_hash_state()
		# print("Current Board state")
		# self.board.print_board()

		self.eval_time = 0
		self.time = time.time()
		# IDA instead of DFS

		sub_move = (-1,-1) 		
		for i in range(3,20):
			print(i)
			best_move = sub_move
			sub_move,move_value = self.min_max(old_move,self.ply,i, hash_value,ispolicy = 1)
			new_time = time.time()
			if new_time - self.time > 15.5:
				break

		print("turn:",self.turn,"move:",sub_move,"value:",move_value)
		
		self.turn += 2

		print("Total time:",new_time - self.time,"depth:",self.depth)	
		print("Eval time:",self.eval_time)
		return best_move


	def min_max(self, old_move,ply,depth,hash_value,alpha = -10000,beta = 10000,ispolicy=1):		

		bs = self.board 		

		if(depth == 0):
			# print(ply,self.find_terminal_state(ply))
			# print(-1*ply,self.find_terminal_state(-1*ply))
			return old_move, self.find_terminal_state(ply)


		
		winner, message = bs.find_terminal_state()
		# print("winner:",winner,"message:",message)
		if message == 'WON':
			return old_move,  ply*self.depth*self.reward*(depth)
		elif message == 'DRAW':
			score = 0
			draw_cnt = 1
			for i in range(4):
				for j in range(4):
					if self.board.block_status[i][j] == 'x':
						score += self.cell_weight[i][j]
					elif self.board.block_status[i][j] == 'o':
						score -= self.cell_weight[i][j]	
					else:
						draw_cnt += 1

			return old_move, score/draw_cnt	

		# print("old move:",old_move)
		possible_moves = self.find_move_cells(old_move)
		if possible_moves == [] :
			possible_moves = self.find_move_cells((-1,-1))
		if possible_moves == []:
			bs.print_board()
				
		# print("possible:",possible_moves)
		random.shuffle(possible_moves)
		

		sub_move = ''
		sub_value = 0
		block_won = 0

		# print("Current hash_value:",hash_value)
		# print("Starting Loop")
		if ply == 1:	
			best_move = '' 
			best_val = -10000
			for move in possible_moves:
				
				bs.board_status[move[0]][move[1]] = 'x'
				hash_value ^= self.keys[16*move[0] + move[1]][2]

				# print("block_won:",block_won)
				# bs.print_board()

				if hash_value in self.hash_depth and self.hash_depth[hash_value] >= depth:
					sub_value = self.hash_table[hash_value]
					# print("Using saved value:",sub_value)

				else:
					block_won = self.check_block_status(move[0]/4,move[1]/4,'x')
					if block_won == 1:
						bs.block_status[move[0]/4][move[1]/4] = 'x'
						sub_move,sub_value = self.min_max(move,ply,depth -1,hash_value,alpha,beta)					
						bs.block_status[move[0]/4][move[1]/4] = '-'
						# Add the reward of winning a block 
						sub_value += self.reward*depth

					elif block_won == 0:
						bs.block_status[move[0]/4][move[1]/4] = 'd'
						sub_move,sub_value = self.min_max(move,-1*ply,depth -1,hash_value,alpha,beta)					
						bs.block_status[move[0]/4][move[1]/4] = '-'
					
					else:
						sub_move,sub_value = self.min_max(move,-1*ply,depth -1,hash_value,alpha,beta)

				# print("sub_move:",sub_move,"sub_value:",sub_value)
				
				# Alpha beta pruning 
				if sub_value > best_val:
					best_val = sub_value
					best_move = move

				alpha = max(alpha,best_val)

				# print("alpha:",alpha,"beta",beta)
				hash_value ^= self.keys[16*move[0] + move[1]][2]
				bs.board_status[move[0]][move[1]] = '-'


				if(beta <= alpha):
					break	

				tmove = time.time()

				if(tmove - self.time > 15.5):
					break

			# print(best_move,best_val) 	
			if hash_value in self.hash_depth and self.hash_depth[hash_value] > depth:
				print("Error while hashing the move", self.hash_depth[hash_value],depth)
			
			else:
				self.hash_table[hash_value] = best_val
				self.hash_depth[hash_value] = depth
				# print("Saving hash_value:",hash_value,self.hash_table[hash_value])

			return best_move,best_val

		else:
			best_move = ''
			best_val  = 10000
			for move in possible_moves:
				
				bs.board_status[move[0]][move[1]] = 'o'
				hash_value ^= self.keys[16*move[0] + move[1]][1]

				if hash_value in self.hash_depth and self.hash_depth[hash_value] >= depth:
					sub_value = self.hash_table[hash_value]
					# print("Using saved value:",sub_value)

				else:
					block_won = self.check_block_status(move[0]/4,move[1]/4,'o')
					# print("block_won:",block_won)	
					if block_won == 1:
						bs.block_status[move[0]/4][move[1]/4] = 'o'
						sub_move,sub_value = self.min_max(move,ply,depth -1,hash_value,alpha,beta)					
						bs.block_status[move[0]/4][move[1]/4] = '-'
						# Add the reward of winning a block 
						sub_value -= self.reward*depth

					elif block_won == 0:
						bs.block_status[move[0]/4][move[1]/4] = 'd'
						sub_move,sub_value = self.min_max(move,-1*ply,depth -1,hash_value,alpha,beta)					
						bs.block_status[move[0]/4][move[1]/4] = '-'
					
					else:
						sub_move,sub_value = self.min_max(move,-1*ply,depth -1,hash_value,alpha,beta)

				# print("sub_move:",sub_move,"sub_value:",sub_value)

				# Alpha beta pruning 
				if sub_value < best_val:
					best_val = sub_value
					best_move = move

				beta = min(beta,best_val)

				# print("alpha:",alpha,"beta",beta)
				hash_value ^= self.keys[16*move[0] + move[1]][1]
				bs.board_status[move[0]][move[1]] = '-'
				
				if(beta <= alpha):
					break		


				tmove = time.time()

				if(tmove - self.time > 15.5):
					break

			# except Exception as e:
			# 	print(possible_moves)
			# 	print(e)
			# 	exit()
			# print(best_move,best_val)		
			if hash_value in self.hash_depth and self.hash_depth[hash_value] > depth:
				print("Error while hashing the move", self.hash_depth[hash_value],depth)
				
			else:
				self.hash_table[hash_value] = best_val
				self.hash_depth[hash_value] = depth
				# print("Saving hash_value:",hash_value,self.hash_table[hash_value])

			return best_move,best_val


	def check_block_status(self,x,y,ply):	
		bs = self.board.board_status
		x = 4*x
		y = 4*y
		#checking if a block has been won or drawn or not after the current move
		for i in range(4):
			#checking for horizontal pattern(i'th row)
			if (bs[x+i][y] == bs[x+i][y+1] == bs[x+i][y+2] == bs[x+i][y+3]) and (bs[x+i][y] == ply):
				return 1
			#checking for vertical pattern(i'th column)
			if (bs[x][y+i] == bs[x+1][y+i] == bs[x+2][y+i] == bs[x+3][y+i]) and (bs[x][y+i] == ply):
				return 1

		#checking for diamond pattern
		#diamond 1
		if (bs[x+1][y] == bs[x][y+1] == bs[x+2][y+1] == bs[x+1][y+2]) and (bs[x+1][y] == ply):
			return 1
		#diamond 2
		if (bs[x+1][y+1] == bs[x][y+2] == bs[x+2][y+2] == bs[x+1][y+3]) and (bs[x+1][y+1] == ply):
			return 1
		#diamond 3
		if (bs[x+2][y] == bs[x+1][y+1] == bs[x+3][y+1] == bs[x+2][y+2]) and (bs[x+2][y] == ply):
			return 1
		#diamond 4
		if (bs[x+2][y+1] == bs[x+1][y+2] == bs[x+3][y+2] == bs[x+2][y+3]) and (bs[x+2][y+1] == ply):
			return 1

		#checking if a block has any more cells left or has it been drawn
		for i in range(4):
			for j in range(4):
				if bs[x+i][y+j] == '-':
					return -1
		# If no cell is remaining then return 0
		return 0	

	def find_terminal_state(self,ply):
		#checks if the game is over(won or drawn) and returns the player who have won the game or the player who has higher blocks in case of a draw
		bs = self.board.block_status

		pply = 'x' if ply == 1 else 'o'
		popp = 'o' if ply == 1 else 'x'

		total_x = 0
		total_y = 0
		total = 0
		total_dash = 0 
		# print("Checking block status")
		#checking if a block has been won or drawn or not after the current move
		
		for i in range(4):
			cnt_x = 0
			cnt_y = 0
			cnt = 0 

			#checking for horizontal pattern(i'th row)
			for j in range(4):
				if bs[i][ j] == 'x':
					cnt_x += 16


				elif bs[i][ j] == 'o':
					cnt_y += 16	
						
				elif bs[i][ j] == '-':
					total_dash += 1	
					cnt += self.check_block_value(i,j,pply)

				else:
					cnt = 0 
					break

			if cnt_x == 4:
				print("Errir in ter")
				return self.depth*self.reward

			elif cnt_y == 4:
				print("Errir in ter")
				return -self.depth*self.reward	

			total_x += cnt_x	
			total_y += cnt_y
			total += cnt	


			cnt_x = 0 
			cnt_y = 0 
			cnt = 0 

			for j in range(4):
				if bs[j][i] == 'x':
					cnt_x += 16


				elif bs[j][i] == 'o':
					cnt_y += 16		

				elif bs[j][i] == '-':
					total_dash += 1
					cnt += self.check_block_value(j, i,pply)

				else:
					cnt = 0
					break

			if cnt_x == 4:
				print("Errir in ter")
				return self.depth*self.reward

			elif cnt_y == 4:
				print("Errir in ter")
				return -self.depth*self.reward			 	

			total_x += cnt_x	
			total_y += cnt_y
			total += cnt


		# in case of draw send an exception value
		if total_dash == 0: 
			# print("Evaluated draw")
			return 0

		#checking for diamond pattern
		
		for i in range(4):
			cnt_ply,cnt_opp = self.block_check_diamond(i+1,pply,popp)
			if cnt_ply == 16*ply:
				print("Error")
				return self.depth*self.reward

			elif cnt_opp == -16*ply:
				print("Errir in ter")
				return -self.depth*self.reward

			else:
				total += ply*cnt_ply - ply*cnt_opp

		# print("total_x:",total_x,"total_y:",total_y,"total_ply:",total_ply)	
		return  total # 4*12 assuming check state returns < 4 


	def check_block_value(self,x,y,ply):	
		
		x = 4*x
		y = 4*y

		hash_value = self.calculate_small_hash(x,y)

		if hash_value in self.small_hash_table:
			# print("Using hash value")
			return self.small_hash_table[hash_value]
		else:
			self.small_hash_table[hash_value] = self.block_value(x,y,ply)		
			return self.small_hash_table[hash_value]

	def block_value(self,x,y,ply):

		nply = 1 if ply == 'x' else -1
		
		opp = 'o' if ply == 'x' else 'x'
		nopp = -1 if ply == 'x' else 1
		
		total_opp = 0
		total_ply = 0
		total_dash = 0 
		bs = self.board.board_status
		# print("Checking block status")
		#checking if a block has been won or drawn or not after the current move
		

		for i in range(4):
			cnt_ply = 0 
			cnt_opp = 0 
			#checking for horizontal pattern(i'th row)
			for j in range(4):
				if bs[x + i][y + j] == ply:
					cnt_ply += 1

				elif bs[x + i][y + j] == '-':
					total_dash += 1	


				elif bs[x + i][y + j] == opp:
					cnt_opp +=1

				else:
					print("Error While counting players")
					break

			if cnt_ply == 4:
				# print("Error")
				return 16*nply

			elif cnt_opp == 4:
				# print("Error")
				return 16*nopp			 	

			if cnt_opp == 0:
				total_ply += cnt_ply	
	
			elif cnt_ply == 0:
				total_opp += cnt_opp

			cnt_ply = 0 
			cnt_opp = 0

			for j in range(4):
				if bs[x + j][y + i] == ply:
					cnt_ply += 1

				elif bs[x + j][y + i] == opp:
					cnt_opp +=1

				elif bs[x + j][y + i] == '-':
					total_dash += 1	

				else:
					print("Error While COunting")
					break

			if cnt_ply == 4:
				# print("Error")
				return 16*nply
			elif cnt_opp == 4:
				# print("Error")
				return 16*nopp	

			if cnt_opp == 0:
				total_ply += cnt_ply	
	
			elif cnt_ply == 0:
				total_opp += cnt_opp	


		# in case of draw send an exception value
		if total_dash == 0: 
			# print("Evaluated draw")
			return 0	

		#checking for diamond pattern
		cnt_ply,cnt_opp = self.check_diamond(x+1,y+1,ply,opp)
		if cnt_ply == 16*ply:
			# print("Error")
			return cnt_ply
		
		elif cnt_opp == 16*nopp:
			# print("Error")
			return cnt_opp

		else:
			if cnt_opp == 0:
				total_ply += cnt_ply	
	
			elif cnt_ply == 0:
				total_opp += cnt_opp	

		cnt_ply,cnt_opp = self.check_diamond(x+1,y+2,ply,opp)
		if cnt_ply == 16*ply:
			# print("Error")
			return cnt_ply
		
		elif cnt_opp == 16*nopp:
			# print("Error")
			return cnt_opp
			
		else:
			if cnt_opp == 0:
				total_ply += cnt_ply	
	
			elif cnt_ply == 0:
				total_opp += cnt_opp	

		cnt_ply,cnt_opp = self.check_diamond(x+2,y+1,ply,opp)
		if cnt_ply == 16*ply:
			# print("Error")
			return cnt_ply
		
		elif cnt_opp == 16*nopp:
			# print("Error")
			return cnt_opp
			
		else:
			if cnt_opp == 0:
				total_ply += cnt_ply	
	
			elif cnt_ply == 0:
				total_opp += cnt_opp	

		cnt_ply,cnt_opp = self.check_diamond(x+2,y+2,ply,opp)
		if cnt_ply == 16*nply:
			# print("Error")
			return cnt_ply
		
		elif cnt_opp == 16*nopp:
			# print("Error")
			return cnt_opp
			
		else:
			if cnt_opp == 0:
				total_ply += cnt_ply	
	
			elif cnt_ply == 0:
				total_opp += cnt_opp	


		return 3*(total_ply*nply + total_opp*nopp)


	def check_diamond(self,x,y,ply,opp):
		bs = self.board.board_status
		
		cnt_ply = 0
		cnt_opp = 0
		cnt_dash = 0

		if bs[x+1][y] == ply:
			cnt_ply = 1

		elif bs[x+1][y] == opp:
			cnt_opp = 1

		elif bs[x+1][y] == '-':
			cnt_dash +=1
	
		else:
			print("Error checking diamon")
			return 0,0

		if bs[x][y +1] == ply:
			cnt_ply +=1


		elif bs[x][y+1] == opp:
			cnt_opp += 1
				
		elif bs[x][y + 1] == '-':
			cnt_dash +=1	

		else:
			return 0,0
	

		if bs[x-1][y] == ply:
			cnt_ply +=1


		elif bs[x-1][y] == opp:
			cnt_opp +=1

		elif bs[x-1][y]  == '-':
			cnt_dash +=1

		else:
			return 0,0


		if bs[x][y-1] == ply:
			cnt_ply +=1

		elif bs[x][y-1] == opp:
			cnt_opp +=1

		elif bs[x][y-1]  == '-':
			cnt_dash +=1	

		else:
			return 0,0 

		if cnt_ply == 4:
			print("Error calculating diamond")
			return 16*(1 if ply == 'x' else -1),0
		elif cnt_opp == 4:
			print("Error calculating diamond")
			return 0,16*(1 if ply == 'x' else -1)

		elif cnt_ply == 0:
			return 0,cnt_opp

		elif cnt_opp == 0:
			return cnt_ply,0

		else:
			return 0,0					


	def block_check_diamond(self,ind,ply,opp):
		bs = self.board.block_status

		cnt = 0
		nply = 1 if ply == 'x' else -1		
		nopp = -1 if ply == 'x' else 1

		if ind == 1:	
			#checking for diamond pattern
			#diamond 1
			cnt_ply = 0
			cnt_opp = 0
			cnt_dash = 0
			cnt = 0

			if bs[1][0] == ply:
				cnt_ply = 1

			elif bs[1][0] == opp:
				cnt_opp = 1


			elif bs[1][0] == '-':
				cnt_dash +=1
				cnt += self.check_block_value(1, 0,ply)


			if bs[0][1] == ply:
				cnt_ply +=1

			elif bs[0][1] == opp:
				cnt_opp +=1	

			elif bs[0][1] == '-':
				cnt_dash +=1
				cnt += self.check_block_value(0, 1,ply)	

			if bs[2][1] == ply:
				cnt_ply +=1

			elif bs[2][1]  == '-':
				cnt_dash +=1
				cnt += self.check_block_value(2, 1,ply)
			
			elif bs[2][1]  == opp:
				cnt_opp +=1				

			if bs[1][2] == ply:
				cnt_ply +=1

			elif bs[1][2]  == '-':
				cnt_dash +=1
				cnt += self.check_block_value(1, 2,ply)

			elif bs[1][2]  == opp:
				cnt_opp +=1					


			if cnt_ply == 4:
				# print("Error")
				return 16*nply,0

			elif cnt_opp == 4:
				# print("Error")
				return 0,16*nopp	

			elif cnt_opp == 0:
				return cnt,0

			elif cnt_ply == 0:
				return 	0,cnt	

			else:
				return 0,0

		elif ind == 2:	
			#diamond 2
			cnt_ply = 0
			cnt_opp = 0
			cnt_dash = 0

			if bs[1][1] == ply:
				cnt_ply +=1

			elif bs[1][1] == opp:
				cnt_opp +=1	

			elif bs[1][1] == '-':
				cnt_dash +=1
				cnt += self.check_block_value(1, 1,ply)
			

			if bs[0][2] == ply:
				cnt_ply +=1

			elif bs[0][2] == opp:
				cnt_opp +=1

			elif bs[0][2] == '-':
				cnt_dash +=1
				cnt += self.check_block_value(0, 2,ply)	


			if bs[2][2] == ply:
				cnt_ply +=1

			elif bs[2][2] == opp:
				cnt_opp +=1

			elif bs[2][2]  == '-':
				cnt_dash +=1
				cnt += self.check_block_value(2, 2,ply)


			if bs[1][3] == ply:
				cnt_ply +=1

			elif bs[1][3] == opp:
				cnt_opp +=1

			elif bs[1][3]  == '-':
				cnt_dash +=1
				cnt += self.check_block_value(1, 3,ply)	

			if cnt_ply == 4:
				# print("Error")
				return 16*nply,0

			elif cnt_opp == 4:
				# print("Error")
				return 0,16*nopp	

			elif cnt_opp == 0:
				return cnt_ply,0

			elif cnt_ply == 0:
				return 	0,cnt_opp	

			else:
				return 0,0	

		elif ind == 3:

			#diamond 3
			cnt_ply = 0
			cnt_opp = 0
			cnt_dash = 0

			if bs[2][0] == ply:
				cnt_ply +=1

			elif bs[2][0] == opp:
				cnt_opp +=1	

			elif bs[2][0] == '-':
				cnt_dash +=1
				cnt += self.check_block_value(2, 0,ply)
			

			if bs[1][1] == ply:
				cnt_ply +=1

			elif bs[1][1] == opp:
				cnt_dash +=1	
			elif bs[1][1] == '-':
				cnt_dash +=1	
				cnt += self.check_block_value(1, 1,ply)

			
			if bs[3][1] == ply:
				cnt_ply +=1

			elif bs[3][1] == opp:
				cnt_opp +=1

			elif bs[3][1]  == '-':
				cnt_dash +=1
				cnt += self.check_block_value(3, 1,ply)


			if bs[2][2] == ply:
				cnt_ply +=1

			elif bs[2][2] == opp:
				cnt_opp +=1

			elif bs[2][2]  == '-':
				cnt_dash +=1
				cnt += self.check_block_value(2, 2,ply)	


			if cnt_ply == 4:
				# print("Error")
				return 16*nply,0

			elif cnt_opp == 4:
				# print("Error")
				return 0,16*nopp	

			elif cnt_opp == 0:
				return cnt_ply,0

			elif cnt_ply == 0:
				return 	0,cnt_opp	

			else:
				return 0,0	

		#diamond 4
		elif ind == 4:
			cnt_ply = 0
			cnt_opp = 0
			cnt_dash = 0

			if bs[2][1] == ply:
				cnt_ply +=1


			elif bs[2][1] == opp:
				cnt_dash +=1	

			elif bs[2][1] == '-':
				cnt_dash +=1
				cnt += self.check_block_value(2, 1,ply)


			if bs[1][2] == ply:
				cnt_ply +=1

			elif bs[1][2] == opp:
				cnt_opp +=1	

			elif bs[1][2] == '-':
				cnt_dash +=1
				cnt += self.check_block_value(1, 2,ply)	


			if bs[3][2] == ply:
				cnt_ply +=1

			elif bs[3][2] == opp:
				cnt_opp +=1	

			elif bs[3][2]  == '-':
				cnt_dash +=1
				cnt += self.check_block_value(3, 2,ply)

			if bs[2][3] == ply:
				cnt_ply +=1

			elif bs[2][3] == opp:
				cnt_opp +=1		

			elif bs[2][3]  == '-':
				cnt_dash +=1
				cnt += self.check_block_value(2, 3,ply)	

			if cnt_ply == 4:
				# print("Error")
				return 16*nply,0

			elif cnt_opp == 4:
				# print("Error")
				return 0,16*nopp	

			elif cnt_opp == 0:
				return cnt,0

			elif cnt_ply == 0:
				return 	0,cnt	

			else:
				return 0,0	
		


		print("Invalid Ind")


	def policy(self,possible_moves,ply):
		bs = self.board
		board_value = []
		print("Policy")

		for move in possible_moves:
			bs.board_status[move[0]][move[1]] = 'x' if ply == 1 else 'o'

			block_won	= self.check_block_status(move[0]/4,move[1]/4,'x' if ply == 1 else 'o') 

			if block_won == 1:
				bs.block_status[move[0]/4][move[1]/4] = 'o'

			elif block_won == 0:
				bs.block_status[move[0]/4][move[1]/4] = 'd'

			board_value.append(self.eval_board())


			if block_won != -1:
				bs.block_status[move[0]/4][move[1]/4] = '-'
		
			bs.board_status[move[0]][move[1]] = 'x' if ply == 1 else 'o'


		# print(possible_moves)
		# print(board_value)
		alpha = -1 if ply == 1 else 1

		index_array = sorted(range(len(board_value)), key = lambda r:board_value[r] )
		possible_moves = [possible_moves[alpha*i] for i in index_array ]

		# print(possible_moves)

		return possible_moves
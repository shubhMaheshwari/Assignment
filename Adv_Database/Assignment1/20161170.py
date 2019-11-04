# Mini SQL Engine. It shows how basic queries work in SQL 

# Imports 
import os 
import re
import sys 
import itertools

from prettytable import PrettyTable


# Engine Class 
class MiniSQLEngine():
	
	# Initialize our class
	def __init__(self):


		# Our ds for storing data
		# self.tables is a dict which each <table-name>:table as the key value pair
		# tables is a Dict() with <column-name>: list of data as column values
		self.tables = {}	


		self.meta_data_filename = "metadata.txt" # Location of the metadata file (contains all the table names and columns)
		self.logical_operators = ["<", "=", ">", "!","<=", "==", ">=", "!=", "<=", ">=", "=!",]
		self.relational_operators = ["and","or"]
		self.load_metadata() 					 # 
		self.load_tables()

	# Load Metedata functions 
	def load_metadata(self):
		with open(self.meta_data_filename) as f:		
			table_name = None
			while True:
				line = f.readline().strip() 
				if line == "": 			
					break
				elif  "<begin_table>" in line:
					if table_name is not None:
						raise Exception("[Error]: No <end_table> found")
					table_name = f.readline().strip()
					self.tables[table_name] = {}
					self.tables[table_name]['_column_ordering'] = []
					self.tables[table_name]['rows'] = []

				elif "<end_table>" in line:
					table_name = None
				else:
					col = line.lower()
					if table_name == None:
						raise KeyError("Error parsing meta_text, column name not under any table name")
					else:
						self.tables[table_name]['_column_ordering'].append(col) 	# Make sure column order is maintained 

			if table_name is not None:
				raise KeyError("[Error]: No <end_table> found")
			
			if len(self.tables) == 0:
				raise Exception("No Metadata found to create tables")


			# print("Meta data loaded")
			

	# Load CSV Function 
	def load_tables(self):
				
		for filename in os.listdir("./"):
			if filename.split('.')[-1] != "csv":	# Do not parse non csv files
				continue

			table_name = filename.split('.')[0]
			if table_name not in self.tables:
				raise Exception("[Error]: Table {} not present in metadata".format(filename))	

			with open(filename) as f:				# Open csv file
				lines = f.read().split('\n')		# Create columns
				for line in lines:					
					data = line.split(',')			# Split data by , (Tab)
					try:
						data = [int(x) for x in data ]  # Convert to int
					except:
						raise Exception("[Error]:Only integers are compatible. Make sure data is tab seperated")


					# Null values are not supported
					if len(data) > 	len(self.tables[table_name]['_column_ordering']):
						raise Exception("[Error]: Extra columns present in csv file")	
					
					elif len(data) <  len(self.tables[table_name]['_column_ordering']):
						raise Exception("[Error]: Null values not supprted")	
					else:		
						# Fill the tables
						self.tables[table_name]['rows'].append(data)	

	# Parse Query 
	def query(self,text):
		"""
			args:
				text: give a text we need to parse the query, seperate details
			
			return:
				dict containing the intructions 
		"""

		# Parse query
		cols,tables,where_exp = self.parse_query(text)

		# Run Data
		data = self.run_query(tables,where_exp) 

		# Print 
		self.print_query(cols,tables,data)


	# Semantic Check on the query 
	def parse_query(self,text):
		"""
			args:
				text: give a text we need to parse the query, load create the data and print the results
			
			return:
				None
		"""

		text = text.strip().lower() 		# Trim the text from whitespaces

		if text == "":
			return [],[],[]

		# Parse different types of queries 

		# Select cols from tables
		if re.match(r'^(select\ ).+(\ from\ ).',text):
			
			cols_end_ind = text.find("from")		# all columms end here


			# Find columns to print 
			cols = text[6:cols_end_ind].strip().split(',') 	# Find all columns name
			cols = [ x.strip() for x in cols ]			# Remove extra spaces
			
			# Select cols from tables where exp
			if re.match(r'^(select\ ).+(\ from\ ).+(\ where\ )',text):
				table_end_ind = text.find("where")

				where_exp = text[table_end_ind+5:].strip()
			else:
				table_end_ind = len(text)
				where_exp = None

			# Find tables to join
			tables = text[cols_end_ind+4:table_end_ind].strip().split(',') 	# Find all columns name
			tables = [ x.strip() for x in tables ]			# Remove extra spaces	

			return cols,tables,where_exp

		else:
			print("[Invalid] Usage: select <cols> from <tables> where <cond>")
		
			return [], [], []

	def check(self,x,y,op):	
		if op == "<":
			return x < y
		elif op == "<":
			return x < y
		elif op == ">":
			return x > y
		elif op == "=":
			return x == y
		elif op == "<=" or op == "<=":
			return x < y
		elif op == ">=" or op == ">=":
			return x < y
		elif op == "!=":
			return x != y


	def perform_logical_operations(self,lr,op,rg,prod_rows,tables):
		"""
			Perform logical operation between the 2 columns
		"""

		lr_ind = None
		rg_ind = None

		# Get the index for operations 
		for i,t in enumerate(tables):
			for j,c in enumerate(self.tables[t]['_column_ordering']):
				if lr == t + "." + c:
					lr_ind = (i,j)
				if rg == t + "." + c:
					rg_ind = (i,j)

		if lr_ind == None and rg_ind is None:
			if len(tables) == 1:
				for j,c in enumerate(self.tables[tables[0]]['_column_ordering']):
					if lr == c:
						lr_ind = (0,j)
					if rg == c:
						rg_ind = (0,j)				
			else:
				print("[Error]: For multiple tables user <table-name>.attr")
				return None

		if lr_ind == None:
			print("[Error]: Cannot find:",lr)
			return None

		if rg_ind == None:
			print("[Error]: Cannot find:",rg)
			return None

		selected_ind = []
		for i,row in enumerate(prod_rows):
			if( self.check( row[lr_ind[0]][lr_ind[1]], row[rg_ind[0]][rg_ind[1]], op) ):
				selected_ind.append(i)

		return selected_ind


	def perform_relational_operators(self,left_ind,op,right_ind):
		"""
			Perform logical operation between the 2 columns
		"""
		final_ind = []

		l = 0
		r = 0

		while l < len(left_ind) and r < len(right_ind):
			if left_ind[l] == right_ind[r]:
				final_ind.append(left_ind[l])
				l = l +1
				r = r +1
			elif left_ind[l] > right_ind[r]:
				if op == "or":
					final_ind.append(right_ind[r])
				r = r +1 
			elif left_ind[l] < right_ind[r]:
				if op == "or":
					final_ind.append(left_ind[l])
				l = l +1 
			else:
				print(":) No Idea what is going on",l,r)

		if op == "or":
			while l < len(left_ind) :
				final_ind.append(left_ind[l])
				l = l +1 

			while r < len(right_ind) :
				final_ind.append(right_ind[r])
				r = r +1 

		return final_ind


	def apply_condition(self,prod_cols,prod_rows,where_exp,tables):
		"""
			Given the condition reduce the size of the prod_rows 

			args:
				prod_rows = sum(lines(tables))*list(table values at index i)
				prod_cols = list(list(column_names))
				where_exp = string containing the expression
		
		"""		
		if where_exp == None:
			return prod_rows	

		condition_list = []
		
		i = 0
		exp_length = len(where_exp)
		cond = []
		word = ""
		while i < exp_length:
			if where_exp[i] == " " and word != "":		
				cond.append(word)
				word = ""
			elif where_exp[i] == " " and word == "":
				pass	
			elif where_exp[i] in ["<", "=", ">", "!"]:

				cond.append(word)	

				if where_exp[i+1] == "=":
					word = where_exp[i:i+2]
					i = i+1
				else:
					word = where_exp[i]	
				cond.append(word)
				word = ""
			else:
				word = word + where_exp[i]


			i = i +1


		cond.append(word)
		word = None

		if len(cond) == 3:
			selected_ind = self.perform_logical_operations(cond[0],cond[1],cond[2],prod_rows,tables)
		elif len(cond) == 7:
			selected_ind1 = self.perform_logical_operations(cond[0],cond[1],cond[2],prod_rows,tables)
			selected_ind2 = self.perform_logical_operations(cond[4],cond[5],cond[6],prod_rows,tables)

			if selected_ind1 is None or selected_ind2 is None:
				return None

			selected_ind = self.perform_relational_operators(selected_ind1,cond[3],selected_ind2)

		else:	
			print("[Error]: Where operation not correct")
			return None

		return_data = []
		for i in selected_ind:
			return_data.append(prod_rows[i])		
		return return_data


	# Run query
	def run_query(self,tables,where_exp):
		"""
			Given an expression, create a print table as needed by the query

			args:
				tables: list of tables
				where_exp: condition to reduce the print table

			return: 
				ds: our dict of list resulted by the query
		"""

		ds = {}



		# Convert from column list to row list
		total_rows = []
		total_cols = []
		for table in tables:
			if table not in self.tables:
				raise Exception("[Error]: Table {} not present in metadata".format(filename))	

			total_rows.append(self.tables[table]['rows'])
			total_cols.append(self.tables[table]['_column_ordering'])


		prod_rows = []
		for prod in itertools.product(*total_rows):
			prod_rows.append(list(prod))

		prod_cols = [x[0] for x in itertools.product(total_cols)]	
		# Apply where condition 
		prod_rows = self.apply_condition(prod_cols,prod_rows,where_exp,tables)

		if prod_rows is None:
			return None


		return prod_rows



	# Print Query 
	def print_query(self,cols,tables,ds):
		"""
			From our ds print to the user
			args:
				ds: list of list to be printed

			return:
				None
		"""

		if ds is None or ds == {}:
			return 

		
		# Check for distinct
		# Apply distinct
		if cols[0] == "distinct":	
			distinct = True
			cols = cols[1:]
		else: 
			distinct = False

		# Convert from list of list to selected inds
		try:
			col_ind_list = []
			col_name_list = []
			for col in cols:
				if col == "*":
					col_ind_list = [ (i,j) for i in range(len(tables)) for j in range(len(self.tables[tables[i]]['_column_ordering']))]
					col_name_list = [ t+'.'+c for i,t in enumerate(tables) for c in self.tables[tables[i]]['_column_ordering']]	
					break
				col_name_list.append(col)
				if '.' in col:
					table,col = col.split('.')
					col_ind = tables.index(table),self.tables[table]['_column_ordering'].index(col)
				else:
					col_ind = 0,self.tables[tables[0]]['_column_ordering'].index(col) 
				col_ind_list.append(col_ind)

		except:
			print("[Error]: Column not found in tables")
			return 

		# Apply agg condtions
		x = PrettyTable()
		x.field_names = col_name_list


		if distinct == True:
			lines = []
			for i, row in enumerate(ds):
				line = []
				for i,j in col_ind_list:
					line.append(row[i][j])
				lines.append(line)

			unique_list = []
			for line in lines:
				if line not in unique_list:
					unique_list.append(line)

			for line in unique_list:
				x.add_row(line)

		else:
			for i, row in enumerate(ds):

				line = []
				for i,j in col_ind_list:
					line.append(row[i][j])

				x.add_row(line)	

		print(x)
		# print(ds)
		pass


	# Interactive mode 
	def interactive(self):
		print("Starting Interactive Mode: Usage:Select <cols> from <tables> where <cond>")

		query_history = []

		while True:
			query = input(">")

			# Commands 
			if query == "exit" or query == "quit":
				break

			for q in query.split(';'): 		# Run multiple queries in a loop	
				self.query(q)

			# Implement reconmendation mode


		print("Exiting Interactive Mode.Bye :)")	

if __name__ == "__main__":
	sql = MiniSQLEngine()


	if len(sys.argv) > 1: 
		# Parse and return the query 
		query = " ".join(sys.argv[1:])
		for q in query.split(';'): 		# Run multiple queries in a loop	
			sql.query(q)


	else:
		sql.interactive()

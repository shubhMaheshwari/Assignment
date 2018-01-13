import MySQLdb
db = MySQLdb.connect("localhost","root","password","COLLEGE")

cursor = db.cursor()
cursor.execute("SELECT * FROM COURSE")
#p = cursor.fetchone()
# while p != None:
# 	print(p)
# 	p = cursor.fetchone()
print(cursor.fetchall()[0])


db.close()
import sys
from flask import Flask, render_template, jsonify
from app import app

def main():
	port = 5000
	try:
		port = int(sys.argv[1])
	except:
		pass
	app.run(debug = True, host = '0.0.0.0', port = port)

if __name__ == '__main__':
	main()	
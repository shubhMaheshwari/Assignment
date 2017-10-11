#This repo contains the code for OS assignment 4

cmd to build: make
cmd to clean: make clean

# Problem 1
## Input n = no.of cars

## Process
	Car are entering a que with random interval.
	They wait in  a que of length 4.
	They get served by a Attender(1 second wait).
	They pay an attender(not nessacary the same attender) amount 100.
	As only 1 ATM is available it takes 0.5 seconds of each car to separatly.
	They exit the station.

## Implementation 
	Used 2 mutex and 2 condition varibles.
	Each car and attender is a thread. 
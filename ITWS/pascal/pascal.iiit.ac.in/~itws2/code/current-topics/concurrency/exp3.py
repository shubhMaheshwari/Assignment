from safe_account import *
from run_exp import run_exp
import sys
# m is the number of multiple credits  in each run
m = int(sys.argv[1])

# n is the number of runs in each experiment
n = int(sys.argv[2])

if __name__ == '__main__':                                                                                         
    run_exp(MyThread.run_threaded, m, n)

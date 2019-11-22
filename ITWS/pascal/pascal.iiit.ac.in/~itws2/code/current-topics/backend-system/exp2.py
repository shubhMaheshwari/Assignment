from concurrent_experiment  import *
from run_exp import *
import sys

# n is the number of runs in each experiment
n = int(sys.argv[1])

if __name__ == '__main__':
    run_exp(MyThread.threaded_append, OperationsOnUser.append_user_name, n)

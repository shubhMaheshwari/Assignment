from operations_on_user import *
from run_exp import run_exp

import sys

def seq_append(i,task):
    u = OperationsOnUser.user
    task(u, "1")
    ans = u.get_name().get_val()
    print "User name appended to %s" % (ans)
    u.get_name().set_val("a")
    return ans


# n is the number of runs in each experiment
n = int(sys.argv[1])

if __name__ == '__main__':
    run_exp(seq_append, OperationsOnUser.append_user_name, n)

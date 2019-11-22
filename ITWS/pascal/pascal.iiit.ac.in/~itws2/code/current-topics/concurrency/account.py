from random import  randint
import time 
import threading

class Account():
    def __init__(self):
        raise Error('Can not instantiate')

    balance = 0

    @staticmethod
    def credit(amt, name, iteration):
        b = Account.balance
        print "    pre balance for thread %s " \
              "in the iteration %d : %d " % \
              (name, iteration, b)

        b = b + amt
        Account.balance = b
        print "    post balance for thread %s " \
              "in the iteration %d : %d " % \
              (name, iteration, b)

    @staticmethod
    def credit_multiple_times(name, counter):
        amt = 10
        while counter:
            # sleep for a random time between 1 and 2 seconds (in 1/10 units)
            # delay = 1 # randint(0,50)/10.0
            # print "   delay = %f" % delay
            # time.sleep(delay)
            print "  %s  crediting in iteration %s at %s:" \
                  % (name, counter, time.ctime(time.time()))

            Account.credit(amt, name, counter)
            counter -= 1

    @staticmethod
    def run_seq(m,r):
        Account.credit_multiple_times("Main", m)
        ans = Account.balance
        print "Net Balance in run %d = %d" % (r, ans)
        Account.balance = 0
        return ans

from account import *
from random import  randint
import time 

class MyThread(threading.Thread):
    def __init__(self, threadID, name, task, amt):
        threading.Thread.__init__(self)
        self.threadID = threadID
        self.name = name
        self.task = task
        self.amt = amt

    def run(self):
        print "Starting run: " + self.name
        delay = 1
        print " delay = %f" % delay
        time.sleep(delay)
        self.task(self.amt)
        print "Exiting run: " + self.name

    @staticmethod
    def threaded_workflow(task, amt):
        thread1 = MyThread(1, "Thread-1", task, amt)
        thread2 = MyThread(2, "Thread-2", task, amt)
        thread1.start()
        thread2.start()

#        print "entering run_threaded[%d] " % (i)
        thread1.join()
        thread2.join()


        ans = Account.balance
        print "Account's balance is %d" % (ans)
        Account.balance = 0
#        print "exiting run_threaded[%d] " % (i)
        return ans

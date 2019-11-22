from operations_on_user import *
from random import  randint
import time 

class MyThread(threading.Thread):
    def __init__(self, threadID, name, task):
        threading.Thread.__init__(self)
        self.threadID = threadID
        self.name = name
        self.task = task

    def run(self):
        print "Starting run: " + self.name
        delay = 1
        print " delay = %f" % delay
        time.sleep(delay)

        self.task(OperationsOnUser.user, self.threadID)
        print "Exiting run: " + self.name

    @staticmethod
    def threaded_append(i, task):
        thread1 = MyThread(1, "Thread-1", task)
        thread2 = MyThread(2, "Thread-2", task)
        thread1.start()
        thread2.start()

        print "entering run_threaded[%d] " % (i)
        thread1.join()
        thread2.join()


        u = OperationsOnUser.user
        ans = u.get_name().get_val()
        print "User name appended to %s" % (ans)
        u.get_name().set_val("a")
        print "exiting run_threaded[%d] " % (i)
        return ans

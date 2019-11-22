from account import *
class MyThread(threading.Thread):
    def __init__(self, threadID, name, counter):
        threading.Thread.__init__(self)
        self.threadID = threadID
        self.name = name
        self.counter = counter

    def run(self):
        print "Starting run: " + self.name
        # credits multiple (= self.counter) times
        Account.credit_multiple_times(self.name, self.counter)
        print "Exiting run: " + self.name

    @staticmethod
    def run_threaded(num_iterations, i):
        thread1 = MyThread(1, "Thread-1", num_iterations)
        thread2 = MyThread(2, "Thread-2", num_iterations)
        thread1.start()
        thread2.start()

        print "entering run_threaded[%d] " % (i)
        thread1.join()
        thread2.join()

        ans = Account.balance
        Account.balance = 0
        print " Net Balance = %d" % (ans)
        print "exiting run_threaded[%d] " % (i)
        return ans

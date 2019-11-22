from concurrent_experiment  import *

Account.lock = threading.Lock()

def fn(amt):
    Account.lock.acquire()
    Account.credit(amt)
    Account.lock.release()

Account.safe_credit = staticmethod(fn)

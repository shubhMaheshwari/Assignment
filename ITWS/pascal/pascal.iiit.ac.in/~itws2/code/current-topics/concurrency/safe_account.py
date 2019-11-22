from concurrent_account  import *

Account.lock = threading.Lock()

def fn(amt, name, iteration):
    Account.lock.acquire()
    Account.unsafe_credit(amt, name, iteration)
    Account.lock.release()

Account.safe_credit = staticmethod(fn)
Account.unsafe_credit = staticmethod(Account.credit)
Account.credit = staticmethod(Account.safe_credit)

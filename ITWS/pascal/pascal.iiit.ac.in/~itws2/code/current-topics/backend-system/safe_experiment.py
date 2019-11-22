from concurrent_experiment  import *

OperationsOnUser.lock = threading.Lock()

def fn(u, tid):
    OperationsOnUser.lock.acquire()
    OperationsOnUser.append_user_name(u, tid)
    OperationsOnUser.lock.release()

OperationsOnUser.safe_append_user_name = staticmethod(fn)

from entities import *
import threading

class OperationsOnUser ():
    def __init__(self):
        raise Error('Can not instantiate')

    user = User(Name("a"), Email("a@b.org"))

    @staticmethod
    def append_user_name(u, append_val):
        p = u.get_name().get_val()
        p = p + str(append_val)
        print u.get_name()
        u.set_name(Name(p))

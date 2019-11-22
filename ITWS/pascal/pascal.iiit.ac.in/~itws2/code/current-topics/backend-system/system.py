from custom_exceptions import *

class System ():
    
    def __init__(self):
        raise Error('Can not instantiate')

    @staticmethod
    def initialize_system(cls):
        System.delegate = cls()
    @staticmethod
    def arity_check(args, n):
       if  (len(args) != n) :
          raise ArityError("arity mismatch: size of args  does not " + 
                           "match operation arity " )

    @staticmethod
    def type_check(args, arg_types):
        for key, value in args.iteritems():
            if not arg_types[key](value):
                raise TypeError("type mismatch: argument %s is not of "
                                "type %s" % (value, key))
    @staticmethod   
    def do(op, **args):
        cls = ops_table[op]
        arg_types  = cls.arg_types
        auth_check = cls.auth_check
        state_check = cls.state_check
        try:
            System.arity_check(args.keys(), len(arg_types.keys()))
            System.type_check(args, arg_types)
            auth_check(args)
            state_check(args)
            return cls.action(args)
        except (ArityError, TypeError, NotAuthorizedError, StateError) as err:
            raise err
class AddUser():
    from entities import is_user
    arg_types = {"user": is_user}

    @staticmethod
    def auth_check(args):
        pass

    @staticmethod
    def state_check(args):
        user = args["user"]
        if System.delegate.user_exists(user):
            raise StateError("user %s already exists in System"
                                % user.to_client())

    @staticmethod
    def action(args):
        user = args["user"]
        user = System.delegate.add_user(user)
        return user
class ShowUsers():

    @staticmethod
    def auth_check():
        pass

    @staticmethod
    def state_check(args):
        pass

    @staticmethod
    def action(args):
        return System.delegate.get_user_set()
class DelUser():
    from entities import is_user
    arg_types = {"user": is_user}

    @staticmethod
    def auth_check(args):
        pass

    @staticmethod
    def state_check(args):
        user = args["user"]
        if not System.delegate.user_exists(user):
            raise StateError("user %s does not exist in System"
                                % user.to_client())

    @staticmethod
    def action(args):
        user = args["user"]
        user_from_system = System.delegate.get_user(email=user.get("email"))
        user = System.delegate.del_user(user_from_system)
        return user
class SetName():
    from entities import is_user, is_name
    arg_types = {"user": is_user, 
                 "name": is_name
                }

    @staticmethod
    def auth_check(args):
        pass

    @staticmethod
    def state_check(args):
        user = args["user"]

        if not System.delegate.user_exists(user):
            raise StateError("user %s does not exist in System"
                                % user.to_client())

    @staticmethod
    def action(args):
        user = args["user"]
        name = args["name"]
        user = System.delegate.set_name(user, name)
        return user
class SetEmail():
    from entities import is_user, is_email
    arg_types = {"user": is_user, 
                 "email": is_email
                }

    @staticmethod
    def auth_check(args):
        pass

    @staticmethod
    def state_check(args):
        user = args["user"]
        email = args["email"]

        if not System.delegate.user_exists(user):
            raise StateError("user %s does not exist in System"
                                % user.to_client())

        elif System.delegate.get_user_by_email(email) is not None:
            raise StateError("Another user exists with the email %s in System"
                                % email.to_client())

    @staticmethod
    def action(args):
        user = args["user"]
        email = args["email"]
        user = System.delegate.set_email(user, email)
        return user
ops_table = {'add_user': AddUser,
             'show_users': ShowUsers,
             'del_user': DelUser,
             'set_name': SetName,
             'set_email': SetEmail
             }

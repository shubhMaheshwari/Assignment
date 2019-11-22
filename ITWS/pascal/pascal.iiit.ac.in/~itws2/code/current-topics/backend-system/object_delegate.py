from entities import *

class ObjectDelegate():
    user_set = []

    def __init__(self):
        self.user_set = []
    def user_exists(self, user):
        return user in self.user_set
    def add_user(self, user):
        self.user_set.append(user)
        user.email.set_user(user)
        return user
    def del_user(self, user):
        self.user_set.remove(user)
        return user
    def get_user_by_email(self, email):
        user_list = filter(lambda user: user.get_email() == email,
                             self.user_set)
        if user_list:
            return user_list[0]
        else:
            None
    def set_email(self, user, email):
        usr = self.get_user_by_email(user.get_email())
        usr.set_email(email=email)
        return user
    def set_name(self, user, name):
        usr = self.get_user_by_email(user.get_email())
        usr.set_name(name=name)
        return user
    def get_users(self):
        return self.user_set

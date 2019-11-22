class Name():
    val = None
    
    def __init__(self, val):
        if is_alphanumeric_str(val):
            self.val = val
        else:
            raise Exception("val %s is not a valid name" % val)

    def get_val(self):
        return self.val

    def set_val(self, val):
        self.val = val

    def to_client(self):
        ret_dict = {}
        ret_dict["val"] = self.val
        return ret_dict

def is_name(value):
    return isinstance(value, Name)

Name.__eq__ = lambda self, other: \
  is_name(other) and \
  self.get_val() == other.get_val()
class Email():
    val = None
    user = None

    def __init__(self, val):
        if is_email_str(val):
            self.val = val
            self.user = None
        else:
            raise Exception("val %s is not a valid email string" % val)

    def get_val(self):
        return self.val

    def set_val(self, val):
        self.val = val

    def get_user(self):
        return self.user

    def set_user(self, user):
        self.user = user

    def to_client(self):
        ret_dict = {}
        ret_dict["val"] = self.val
        return ret_dict

def is_email(value):
    return isinstance(value, Email)

Email.__eq__ = lambda self, other: \
  is_email(other) and \
  self.get_val() == other.get_val()
class User():
    name = None
    email = None

    def __init__(self, name, email):
        self.name = name
        self.email = email

    def get_name(self):
        return self.name

    def set_name(self, name):
        self.name = name

    def get_email(self):
        return self.email

    def set_email(self, email):
        self.email = email
        self.email.set_user(self)

    def to_client(self):
        ret_dict = {}
        ret_dict["name"] = self.name.to_client()
        ret_dict["email"] = self.email.to_client()
        return ret_dict

def is_user(value):
    return isinstance(value, User)

User.__eq__ = lambda self, other: \
  is_user(other) and \
  self.get_email() == other.get_email()
import re
def is_alphanumeric_str(value):
    return isinstance(value, str) and not re.search('[^a-zA-Z\d. ]+', value)


def is_email_str(value):
    return isinstance(value, str) and re.search('[^@]+@[^@]+\.[^@]+', value)

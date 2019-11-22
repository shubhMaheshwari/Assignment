import unittest
from unittest import TestCase
from system import *
from object_delegate import *
class TestAddUser(TestCase):
    TESTING = True

    def setUp(self):
        System.initialize_system(ObjectDelegate)

    def tearDown(self):
        System.delegate = None

    def test_add_user_passes(self):
        print "test_add_user_passes"
         
        user=User(name=Name(val="me mine myself"),
                  email=Email(val="abc@gnu.org"))

        System.do("add_user", user=user)

        self.assertEqual(len(System.delegate.user_set), 1)


    def test_add_user_raises_arity_error(self):
        print "test_add_user_raises_arity_error"

        user=User(name=Name(val="me mine myself"),
                  email=Email(val="abc@gnu.org"))

        with self.assertRaises(ArityError):
            System.do("add_user")


    def test_add_user_raises_type_check_error(self):
        print "test_add_user_raises_type_check_error"

        user=User(name=Name(val="me mine myself"),
                  email=Email(val="abc@gnu.org"))

        with self.assertRaises(TypeError):
            System.do("add_user", user="abc")


    def test_add_existing_user_raises_state_error(self):
        print "test_add_existing_user_raises_state_error"

        user=User(name=Name(val="me mine myself"),
                  email=Email(val="abc@gnu.org"))

        System.do("add_user", user=user)

        with self.assertRaises(StateError):
            System.do("add_user", user=user)
class TestDelUser(TestCase):
    TESTING = True

    def setUp(self):
        System.initialize_system(ObjectDelegate)

    def tearDown(self):
        System.delegate = None

    def test_del_user_passes(self):

        user=User(name=Name(val="me mine myself"),
                  email=Email(val="abc@gnu.org"))

        System.delegate.add_user(user)  ##added user to the system
        self.assertEqual(len(System.delegate.user_set), 1)

        System.delegate.del_user(user)
        self.assertEqual(len(System.delegate.user_set), 0)

    def test_del_user_raises_arity_error(self):
        print "test_del_user_raises_arity_error"

        with self.assertRaises(ArityError):
            System.do("del_user")

    def test_del_user_raises_type_check_error(self):
        print "test_del_user_raises_type_check_error"

        with self.assertRaises(TypeError):
            System.do("del_user", user="abc")

    def test_del_user_raises_state_error_with_no_existing_user(self):
        print "test_del_user_raises_state_error_with_no_existing_user"

        user=User(name=Name(val="me mine myself"),
                  email=Email(val="abc@gnu.org"))
        
        ## user not added to the system
        with self.assertRaises(StateError):
            System.do("del_user", user=user)
class TestSetEmail(TestCase):
    TESTING = True

    def setUp(self):
        System.initialize_system(ObjectDelegate)

    def tearDown(self):
        System.delegate = None

    def test_set_email_passes(self):
        print "test_set_email_passes"

        user=User(name=Name(val="me mine myself"),
                  email=Email(val="abc@gnu.org"))

        System.delegate.add_user(user)  ##added user to the system
        email = Email(val="xyz@gnu.org")
        System.do("set_email", user=user, email=email) #update user

        updated_user = System.delegate.get_user_by_email(email) # retrieve user
        self.assertEqual(updated_user.get_email(), email) # compare emails


    def test_set_email_raises_arity_error(self):
        print "test_set_email_raises_arity_error"

        user=User(name=Name(val="me mine myself"),
                      email=Email(val="abc@gnu.org"))

        with self.assertRaises(ArityError):
            System.do("set_email", user=user)


    def test_set_email_raises_type_check_error(self):
        print "test_set_email_raises_type_check_error"

        user=User(name=Name(val="me mine myself"),
                      email=Email(val="abc@gnu.org"))

        with self.assertRaises(TypeError):
            System.do("set_email", user=user, email=user)


    def test_set_email_raises_state_error_non_existing_user(self):
        print "test_set_email_raises_state_error_non_existing_user"

        user=User(name=Name(val="me mine myself"),
                      email=Email(val="abc@gnu.org"))

        # above user not added to the system
        email = Email(val="ttk@gnu.org")

        with self.assertRaises(StateError):
            System.do("set_email", user=user, email=email)


    def test_set_email_raises_state_error_existing_email(self):
        print "test_set_email_raises_state_error_existing_email"

        email1 = Email(val="abc@gnu.org")
        email2 = Email(val="xyz@gnu.org")

        user1=User(name=Name(val="user 1"),
                      email=email1)

        user2=User(name=Name(val="user 2"),
                      email=email2)

        System.delegate.add_user(user1)  ##added user1 to the system
        System.delegate.add_user(user2)  ##added user2 to the system


        with self.assertRaises(StateError):
            System.do("set_email", user=user1, email=email2)
class TestSetName(TestCase):
    TESTING = True

    def setUp(self):
        System.initialize_system(ObjectDelegate)

    def tearDown(self):
        System.delegate = None

    def test_set_name_passes(self):
        print "test_set_name_passes"

        email=Email(val="abc@gnu.org")
        user=User(name=Name(val="user name"),
                  email=email)

        System.delegate.add_user(user)  ##added user to the system
        name = Name(val="new user name")
        System.do("set_name", user=user, name=name) #update user

        updated_user = System.delegate.get_user_by_email(email) # retrieve user
        self.assertEqual(updated_user.get_name(), name) # compare names


    def test_set_name_raises_arity_error(self):
        print "test_set_name_raises_arity_error"

        user=User(name=Name(val="me mine myself"),
                      email=Email(val="abc@gnu.org"))

        with self.assertRaises(ArityError):
            System.do("set_name", user=user)


    def test_set_name_raises_type_check_error(self):
        print "test_set_name_raises_type_check_error"

        user=User(name=Name(val="me mine myself"),
                      email=Email(val="abc@gnu.org"))

        with self.assertRaises(TypeError):
            System.do("set_name", user=user, name=user)


    def test_set_name_raises_state_error_non_existing_user(self):
        print "test_set_name_raises_state_error_non_existing_user"

        user=User(name=Name(val="user name"),
                      email=Email(val="abc@gnu.org"))

        # above user not added to the system
        name = Name(val="new user name")

        with self.assertRaises(StateError):
            System.do("set_name", user=user, name=name)
if __name__ == '__main__':
    unittest.main()

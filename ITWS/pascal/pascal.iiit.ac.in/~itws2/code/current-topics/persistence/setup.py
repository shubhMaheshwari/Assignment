from runtime.persistence.entities import *
from flask import Flask
from runtime.config.flask_app_config import *
class Setup():
    ctxt = None

    @staticmethod
    def setup():

        app = Flask(__name__)

        app.config['SQLALCHEMY_TRACK_MODIFICATIONS'] = False

        # app.config['SQLALCHEMY_DATABASE_URI'] = 'mysql+oursql://root:root@localhost/userdirectory'
        app.config['SQLALCHEMY_DATABASE_URI'] = SQLALCHEMY_DATABASE_URI

        db.init_app(app)

        db.app = app

        with app.app_context():
            db.create_all()

        Setup.ctxt = app

def pr_db_name(sym, n):
        print "%s = %s" % (sym, n.to_client())

def pr_db_email(sym, e):
        print "%s = %s" % (sym, e.to_client())


def pr_db_user(sym, u):
        print "%s = %s" % (sym, u.to_client())


def mk_db_name(sym, v):
        n = Name(val=v)
        pr_db_name(sym,n)
        return n


def mk_db_email(sym, v):
        e = Email(val=v)
        pr_db_email(sym,e)
        return e


def mk_db_user(sym, n,e):
        u = User(name=n,email=e,roles=[])
        pr_db_user(sym,u)
        return u

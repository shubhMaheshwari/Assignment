from setup import *
Setup.setup()

with Setup.ctxt.app_context():
	n1 = mk_db_name("n1", "one")
	n1.save()
	pr_db_name("n1", n1)

	n2 = mk_db_name("n2", "two")
	n2.save()
	pr_db_name("n2", n2)

	e1 = mk_db_email("e1", "e1@g.com")
	e1.save()
	pr_db_email("e1", e1)

	e2 = mk_db_email("e2", "e2@g.com")
	e2.save()
	pr_db_email("e2", e2)

	u1 = mk_db_user("u1", n1,e1)
	u1.save()
	pr_db_user("u1", u1)

	u2 = mk_db_user("u2", n2,e2)
	u2.save()
	pr_db_user("u2", u2)

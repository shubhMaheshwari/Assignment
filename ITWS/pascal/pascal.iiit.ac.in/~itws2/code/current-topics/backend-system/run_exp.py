 # runs an expirement  with a task n times
def run_exp(exp, task, n):
    ans = []
    i = 0
    while i < n:
        ans.append(exp(i, task))
        i = i+1

    print "Answers in %d runs = %s " % (n, ans)

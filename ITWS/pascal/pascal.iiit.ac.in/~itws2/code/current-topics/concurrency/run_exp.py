def run_exp(exp, m, n):
    ans = []
    i = 0
    while i < n:
        ans.append(exp(m,i))
        i = i+1

    print "Answers in %d runs = %s " % (n, ans)

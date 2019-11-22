import sys
import os
from collections import OrderedDict

database = OrderedDict()
memory = OrderedDict()
registers = {}
trans_ids = []
id2commands = {}
ans = ""

def init_value(line):
    line = line.strip().split()
    assert len(line)%2==0
    for i in range(0, len(line), 2):
        database[line[i].strip()] = int(line[i+1].strip())
    
def read(path):
    num = 0
    tid = None
    flag = False
    with open(path,'r') as f:
        for line in f.readlines():
            if not flag:
                init_value(line)
                flag = True
                continue
            if line.strip() == "":
                continue
            if num:
                id2commands[tid].append(line.strip())
                num-=1
            else:
                tid, num = line.strip().split()
                tid, num = tid.strip(), int(num.strip())
                if tid in id2commands:
                    sys.exit("Repeated Transaction")
                else:
                    trans_ids.append(tid)
                    id2commands[tid] = []

def output_status():
    global ans
    sort_memory = sorted(memory)
    for i, var in enumerate(sort_memory):
        ans += "{} {}".format(var, memory[var])
        if i!=len(sort_memory) - 1:
            ans += " "
    ans += "\n"
    sort_database = sorted(database)
    for i, var in enumerate(sort_database):
        ans += "{} {}".format(var, database[var])
        if i!=len(sort_database) - 1:
            ans += " "
    ans += "\n"

def db_execute(cmd, op, tid):
    global ans
    cmd = cmd[:-1].split('(')[1].strip()
    if ',' in cmd:
        var, tmp = cmd.split(',')
        var, tmp = var.strip(), tmp.strip()
    if op.lower() == "read":
        if var in memory:
            registers[tmp] = memory[var]
        else:
            registers[tmp] = database[var]
            memory[var] = database[var]
    
    elif op.lower() == "write":
        ans += "<{}, {}, ".format(tid, var)
        if var not in memory:
            memory[var] = database[var]
        ans += "{}>\n".format(memory[var])
        memory[var] = registers[tmp]
        output_status()
    
    elif op.lower() == "output":
        if cmd in memory:
            database[cmd] = memory[cmd]
        else:
            memory[cmd] = database[cmd]
def check(inp):
    try:
        return int(inp)
    except:
        return registers[inp]

def arith_execute(c, a, b, op):
    a, b = check(a), check(b)
    if op == "+":
        registers[c] = a + b
    elif op == "-":
        registers[c] = a - b
    elif op == "*":
        registers[c] = a * b
    elif op == "/":
        if b==0:
            sys.exit("Divide by zero")
        registers[c] = a / b
    

def execute(tid, start, end):
    db_ops = ["read", "write", "output"]
    ops = ["+", "-", "*", "/"]
    for i in range(start, end):
        cmd = id2commands[tid][i]
        flag = False
        for op in db_ops:
            if op in cmd.lower():
                db_execute(cmd, op, tid)
                flag = True
                break
        if flag:
            continue
        cmd = cmd.strip()
        cmd = cmd.split(":=")
        c = cmd[0].strip()
        for op in ops:
            if op in cmd[1].strip():
                a, b = cmd[1].strip().split(op)
                a, b = a.strip(), b.strip()
                arith_execute(c, a, b, op)
                break

def calc(x):
    l = 0
    global ans
    while True:
        cnt = 0
        start = l * x
        for i, tid in enumerate(trans_ids):
            num = len(id2commands[tid])
            if start == 0:
                ans += "<START {}>\n".format(tid)
                output_status()
            if num <= start:
                cnt+=1
                continue
            
            end = min((l+1)*x, num)
            execute(tid, start, end)
            if end == num:
                ans += "<COMMIT {}>\n".format(tid)
                output_status()
        l += 1
        if cnt == len(trans_ids):
            break

if __name__ == "__main__":
    path = sys.argv[1]
    x = int(sys.argv[2])
    read(path)
    calc(x)
    with open("20161170_1.txt","w") as f:
        f.write(ans)
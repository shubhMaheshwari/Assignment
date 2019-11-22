import sys
import os, copy
from collections import OrderedDict

database = OrderedDict()

def init_value(line):
    line = line.strip().split()
    assert len(line)%2==0
    tmp = {}
    for i in range(0, len(line), 2):
        tmp[line[i].strip()] = int(line[i+1].strip())
    for i in sorted(tmp):
        database[i] = tmp[i]

def read(path):
    flag = False
    data = []
    with open(path, 'r') as f:
        for line in f.readlines():
            if not flag:
                init_value(line)
                flag = True
                continue
            if line.strip() == "":
                continue
            data.append(line.strip())
    
    return data

def left_trans(cmd, done_trans):
    trans = []
    cmd = cmd.split('(')[1].split(')')[0]
    trs = list(map(lambda x: x.strip(), cmd.split(',')))
    for tr in trs:
        if tr in done_trans:
            continue
        trans.append(tr)
    return trans

def recover(data):
    end_ckpt = False
    start_ckpt = False
    data = data[-1::-1]
    done_trans = []
    trans = []
    cnt = 0
    for cmd in data:
        if cmd == "<END CKPT>":
            end_ckpt = True
        elif "<START CKPT" in  cmd:
            if end_ckpt:
                break
            trans = copy.deepcopy(left_trans(cmd, done_trans))
            start_ckpt = True
            cnt = 0
        elif "<COMMIT" in cmd:
            tr = cmd.split()[1][:-1]
            done_trans.append(tr)
        elif "<START" in cmd:
            if start_ckpt:
                tr = cmd.split()[1][:-1]
                if tr in trans:
                    cnt+=1
                if cnt == len(trans):
                    break
        else:
            [tr, var, val] = list(map(lambda x: x.strip(), cmd[1:-1].split(',')))
            if tr not in done_trans:
                database[var] = val

def output_status():
    ans = ""
    for i, var in enumerate(database):
        ans += "{} {}".format(var, database[var])
        if i!=len(database) - 1:
            ans += " "
    ans += "\n"
    with open('20161170_2.txt', 'w') as f:
        f.write(ans)

if __name__ == "__main__":
    path = sys.argv[1]
    data = read(path)
    recover(data)
    output_status()

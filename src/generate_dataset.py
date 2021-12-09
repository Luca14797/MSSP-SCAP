from random import seed
from random import randint
import json


def generate_id(n, dim_list):
    res = []
    i = 1
    while i <= n:
        for dim in dim_list:
            l = []
            for _ in range(dim):
                l.append(str(i))
                i = i + 1

            res.append(l)
    return res


def generate_time(dim_list):
    res = []
    for dim in dim_list:
        l = []
        for _ in range(dim):
            l.append(randint(2, 20))

        res.append(l)
    return res


def generate_priority(dim_list):
    res = []
    for dim in dim_list:
        l = []
        for _ in range(dim):
            l.append(randint(-5, 10))

        res.append(l)
    return res


def main():

    o_r = 5
    beta = 100
    s = 6
    n = o_r * beta
    dim_list = []

    res = randint(1, n/2)
    n = n - res
    dim_list.append(res)
    for i in range(s - 2):
        res = randint(1, n)
        dim_list.append(res)
        n = n - res

    dim_list.append(n)

    n = o_r * beta

    id = generate_id(n, dim_list)
    time = generate_time(dim_list)
    priority = generate_priority(dim_list)

    with open('datasets/Agnetis_' + str(o_r) + '_' + str(beta) + '.dat', 'w') as f:
        f.write('S = {"GYN", "GS", "ENT", "URO", "DS", "ORTH"};\n\n')
        # f.write('J = {"OR1", "OR2", "OR3", "OR4", "OR5", "OR6", "OR7", "OR8", "OR9", "OR10"};\n\n')
        # f.write('J = {"OR1", "OR2", "OR3", "OR4", "OR5", "OR6", "OR7", "OR8", "OR9", "OR10", "OR11", "OR12", "OR13", "OR14", "OR15"};\n\n')
        f.write('J = {"OR1", "OR2", "OR3", "OR4", "OR5"};\n\n')
        f.write('DAYS = {1, 2, 3, 4, 5};\n\n')
        f.write('N = %d;\n\n' %n)

        f.write('I = %s;\n\n' %json.dumps(id))
        f.write('P = %s;\n\n' %time)
        f.write('R = %s;\n\n' %priority)
        f.write('NOT = 25;\n\n')
        f.write('O_max = 42;\n\n')
        f.write('S_min = [2, 6, 1, 1, 3, 6];\n\n')
        f.write('S_max = [6, 10, 5, 5, 7, 10];\n\n')
        f.write('PS = [1, 2, 1, 1, 1, 2];\n\n')
        # f.write('NA = [{"OR1", "OR2", "OR4", "OR5", "OR6", "OR7", "OR9", "OR10"}, {"OR5", "OR10"}, {"OR1", "OR2", "OR4", "OR5", "OR6", "OR7", "OR9", "OR10"}, {"OR2", "OR3", "OR4", "OR5", "OR7", "OR8", "OR9", "OR10"}, {"OR5", "OR10"}, {"OR1", "OR2", "OR3", "OR6", "OR7", "OR8"}];\n\n')
        # f.write('NA = [{"OR1", "OR2", "OR4", "OR5", "OR6", "OR7", "OR9", "OR10", "OR11", "OR12", "OR14", "OR15"}, {"OR5", "OR10", "OR15"}, {"OR1", "OR2", "OR4", "OR5", "OR6", "OR7", "OR9", "OR10", "OR11", "OR12", "OR14", "OR15"}, {"OR2", "OR3", "OR4", "OR5", "OR7", "OR8", "OR9", "OR10", "OR12", "OR13", "OR14", "OR15"}, {"OR5", "OR10", "OR15"}, {"OR1", "OR2", "OR3", "OR6", "OR7", "OR8", "OR11", "OR12", "OR13"}];\n\n')
        f.write('NA = [{"OR1", "OR2", "OR4", "OR5"}, {"OR5"}, {"OR1", "OR2", "OR4", "OR5"}, {"OR2", "OR3", "OR4", "OR5"}, {"OR5"}, {"OR1", "OR2", "OR3"}];\n\n')
        f.write('W = 90;\n\n')

    k = 0
    for i in range(s):
        for j in range(len(time[i])):
            k = k + (time[i][j] * (90 - priority[i][j]))
    
    print("Best: %s" %k)


if __name__ == "__main__":
    main()

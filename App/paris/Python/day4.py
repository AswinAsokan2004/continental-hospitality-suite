import copy
def duplicate(t):
    a = copy.deepcopy(t)
    index = int(0)
    ret_list = list()
    rep = list()
    while index != len(t):
        for x in range(index+1,len(a)):
            if t[index] == a[x]:
                rep.append(t[index])
                break
        else:
            ret_list.append(t[index])
        index = index + 1
    return ret_list,rep
a,b = duplicate((1,3,2,1,4,1,[1,4,3],[24,56],[1,4,3],3)) 
setter = set(b)   
print(a,setter,'rep = ',b)


        
def pro(list,target):
    # ret = list()
    for x in range(len(list)):
        for i in range(x,len(list)):
            if list[x]+list[i] == target:
                return [list[x],list[i]],[x,i]
                break

    return [],[]
l,p = pro([1,4,6,2,4,3,7],120)
print(l,'values at index',p)
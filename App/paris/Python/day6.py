# import numpy as np
# a = np.array([1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16],dtype='int16')
# a = a.reshape(2,2,2,2)
# # print(a)
# # print(a.dtype)
# # print('dimension',a.ndim)
# # b = a.copy()
# # c = a.view()
# # c[0][0][0][0] = 90
# # print(b.base)
# # print(c.base)
# # print(a)
# # print(b)
# for x in a:
    
#  x = 9
from numpy import random
a = random.randint(1,10,(2,5))
b = random.randint(1,10,(2,1))

print(a)
# print(b)
# print(a+b)
print(a.mean(axis=0))
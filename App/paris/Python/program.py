    #input_value = int(input('Enter the value:   '))
def prime():
    for input_value in range(0,100):
        if(input_value == 2):
            print(input_value,'Prime')
        elif input_value in (0,1):
            print(input_value,'Not prime')
        else:
            for x in range(2,input_value):
                if input_value%x == 0:
                    print(input_value,'Not Prime')
                    break
            else:
                print(input_value,'Prime')    
#prime()
def factorial(num):
    ret = int(1)
    for x in range(1,num+1):
        ret= ret *x
    return ret
def degit_sum(digit):
    ret = int(0)
    while digit != 0:
        ret+=digit % 10
        digit//=10
    return ret
#prime()
#print(factorial(6))
#print(degit_sum(543261))
a = 'python is a programming language'
a = a.split('is')
print(a)
a = 'hai'
a = a.upper()
print(a)

def palindrome(a = 'aaaa'):
    for x in range((len(a)//2)+1):
        if a[x] != a[-1 + -x]:
            print('reason',a[x],a[-1+-x])
            print(a,'Not palindrome')
            break
    else:
        print(a,'palindrome')

palindrome()

def string_pro2(String):
    if len(String) < 4:
        return str()
    else:
        return String[0:2] + String[-2] + String[-1]
print('The string is ',string_pro2('hellow'))

def replacer(string):
    if len(string) > 3 and string[-1] == 'e':
        return string + 'n'
    else:
        return string
print(replacer('take'))

# def pro(array,target):
#     for x in array:
#         for x in array():
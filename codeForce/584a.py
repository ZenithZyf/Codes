n, t = map(int, input().split())
number = ''

if ((n == 1) and (t == 10)):
    number = -1
    
elif (t == 10):
    number += str(t)
    for i in range(n - 2):
        number += '0'

else:
    for i in range(n):
        number += str(t)

print(number)
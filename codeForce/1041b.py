from math import gcd

a, b, x, y = map(int, input().split())

g = gcd(x, y)
x = x // g
y = y // g

print(min(a // x, b // y))
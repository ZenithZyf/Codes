from math import sqrt

a, b, c = map(int, input().split())

l1 = sqrt(a * b // c)
l2 = sqrt(b * c // a)
l3 = sqrt(a * c // b)

print(int(4 * (l1 + l2 + l3)))
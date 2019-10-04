n, k = map(int, input().split())

a = sorted(len(input()) for i in range(n))
p = len(input())

t = a.index(p)

a, b = t, t + a.count(p)
print(1 + a + a // k * 5, b + (b - 1) // k * 5)
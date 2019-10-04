a, b = map(int, input().split())

c = min(a, b)
remain = max(a, b) - c

d = remain // 2

print(c, d)
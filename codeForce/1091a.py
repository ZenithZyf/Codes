y, b, r = map(int, input().split())

y += 2
b += 1

print(min(y, b, r) * 3 - 3)
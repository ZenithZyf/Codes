n = int(input())
burles = list(map(int, input().split()))

most = max(burles)

total = 0
for i in range(n):
    total += most - burles[i]

print(total)
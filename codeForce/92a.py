n, m = map(int, input().split())
m = m % sum(i for i in range(1, n + 1))
i = 1

while True:
    m -= i
    if m == 0:
        print(0)
        break
    elif m < 0:
        print(m + i)
        break
    i += 1
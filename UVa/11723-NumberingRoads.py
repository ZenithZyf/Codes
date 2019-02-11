import sys
input = lambda : sys.stdin.readline()
case = 0

while True:
    R, N = list(map(int, input().split()))
    if R == 0 or N == 0:
        break
    case += 1

    res, rem = divmod(R-N, N)
    res += 1 if rem else 0
    if 0 <= res <= 26:
        print("Case %d: %d" %(case,res))
    else:
        print("Case %d: impossible" %(case))


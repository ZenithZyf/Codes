import sys
from math import asin,cos
input = lambda : sys.stdin.readline()

N = int(input().strip())
for _ in range(1,N+1):
    d, v, u = map(int, input().split())
    if u<=v or u<=0 or v<=0 or d<=0:
        print("Case %d: can't determine" %_)
    else:
        theta = asin(v/u)
        up = u*cos(theta)
        T1 = d/u
        T2 = d/up
        df = T2-T1

        print("Case %d: %.3f" %(_,df))
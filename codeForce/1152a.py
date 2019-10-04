n, m = map(int, input().split())
a = list(map(int, input().split()))
b = list(map(int, input().split()))

c = [x % 2 for x in a]
d = [y % 2 for y in b]

c_odd = sum(c)
c_even = n - c_odd

d_odd = sum(d)
d_even = m - d_odd

print(min(c_odd, d_even) + min(d_odd, c_even))
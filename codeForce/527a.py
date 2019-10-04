a, b = map(int, input().split())
cnt = 0

if a < b:
	a, b = b, a

while a > 0 and b > 0 and a != b:
	cnt += a // b
	a, b = b, a % b

print(cnt)

n, s = map(int, input().split())

if n > s:
	need = 1
elif s % n == 0:
	need = s // n
else:
	need = s // n + 1

print(need)
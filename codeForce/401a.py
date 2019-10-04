n, x = map(int, input().split())
num = list(map(int, input().split()))

if sum(num) == 0:
	need = 0
elif abs(sum(num)) % x == 0:
	need = abs(sum(num)) // x
else:
	need = abs(sum(num)) // x + 1

print(need)
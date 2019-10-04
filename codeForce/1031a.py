w, h, k = map(int, input().split())
cell = 0

for i in range(k):
	cell += 2 * (w + h) - 4
	w -= 4
	h -= 4

print(cell)
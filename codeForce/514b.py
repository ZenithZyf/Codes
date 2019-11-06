n, x0, y0 = map(int, input().split())

vertical = 0
shot = set()

for i in range(n):
	x, y = map(int, input().split())

	if x == x0:
		vertical = 1
	else:
		slope = (y - y0) / (x - x0)
		shot.add(slope)

shot_num = len(shot)
if vertical == 1:
	print(shot_num + 1)
else:
	print(shot_num)
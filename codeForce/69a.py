class point:
	def __init__(self, x=0, y=0, z=0):
		self.x, self.y, self.z = x, y, z
	def __iadd__(self, other):
		self.x += other.x
		self.y += other.y
		self.z += other.z
		return self

f = point(0, 0, 0)
for i in xrange(input()):
	x, y, z = map(int, raw_input().split())
	f += point(x, y, z)
if f.x == 0 and f.y == 0 and f.z == 0:
	print("YES")
else:
	print("NO")
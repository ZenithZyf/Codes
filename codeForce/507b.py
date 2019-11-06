import math

r, x, y, x1, y1 = map(int, input().split())

print(math.ceil(math.sqrt((x1 - x) ** 2 + (y1 - y) ** 2) / (2 * r)))
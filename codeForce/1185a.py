pos = list(map(int, input().split()))

d = pos.pop()
pos.sort()

mov = 0
mov += max(0, d - (pos[1] - pos[0]))
mov += max(0, d - (pos[2] - pos[1]))

print(mov)

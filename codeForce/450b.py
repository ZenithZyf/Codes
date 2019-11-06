x, y = map(int, input().split())
n = int(input())
number = [x, y, y - x, 0 - x, 0 - y, x - y]

fn = number[(n % 6) - 1]

print(fn % (10 ** 9 + 7))
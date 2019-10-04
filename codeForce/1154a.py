numbers = list(map(int, input().split()))

numbers.sort()
print(numbers[3] - numbers[2], numbers[3] - numbers[1], numbers[3] - numbers[0])
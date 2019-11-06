a, b, c = map(int, raw_input().split())

maxValue = max((a + b + c), max((a * (b + c)), max((a* b + c), max(a + b * c, max(a * b * c, (a + b) * c)))))

print(maxValue)
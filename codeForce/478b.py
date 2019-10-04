def nf(n):
	if n < 2:
		return 0
	else:
		return (n * (n - 1) // 2)


def main():
	n, m = map(int, input().split())
	minPairs = (m - n % m) * nf(n // m) + (n % m) * nf(n // m + 1)
	maxPairs = nf(n - m + 1)

	print(minPairs, maxPairs)

if __name__ == '__main__':
	main()


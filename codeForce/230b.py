def get_prime(upper):
	upper += 1
	p = [0] * upper
	primes = [2]

	for i in range(3, upper, 2):
		if p[i]:
			continue
		primes.append(i)
		for j in range(i * i, upper, i):
			p[j] = 1

	return primes

def main():
	t = set([p * p for p in get_prime(int(1E6))])
	_ = input()
	nums = list(map(int, input().split()))
	print('\n'.join('YES' if i in t else 'NO' for i in nums))

if __name__ == '__main__':
	main()
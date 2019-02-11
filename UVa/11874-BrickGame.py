def main():
	n = int(input())
	for idx in range(n):
		strs = input()
		value = [int(v) for v in strs.split()]
		num, age = value[0], value[1:]
		print("Case {}: {}".format(idx+1, age[(num-1)//2]))

if __name__ == '__main__':
	main()
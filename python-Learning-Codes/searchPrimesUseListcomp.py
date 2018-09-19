a = [25,29,31,35,37,39]
#primes = [x for x in a for y in range(2,x) if any(x % y == 0)]
primes = [x for x in a if all(x % y!=0 for y in range(2,x))]
print(primes)
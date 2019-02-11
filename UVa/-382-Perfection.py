def main():
    n = input()
    value = [int(v) for v in n.split()]
    print("PERFECTION OUTPUT")
    for num in value:
        if num == 0:
            break
        sum = 0
        for x in range(1,num//2+1):
            if num%x == 0:
                sum += x
        if sum == num:
            print("{:>5}  PERFECT".format(num))
        elif sum < num:
            print("{:>5}  DEFICIENT".format(num))
        elif sum > num:
            print("{:>5}  ABUNDANT".format(num))
    print("END OF OUTPUT")

if __name__ == '__main__':
    main()
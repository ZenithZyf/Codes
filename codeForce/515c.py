def main():
    _ = input()
    num = input()

    ans = []

    for d in num:
        if d == '2':
            ans.append('2')
        elif d == '3':
            ans.append('3')
        elif d == '4':
            ans.append('3')
            ans.append('2')
            ans.append('2')
        elif d == '5':
            ans.append('5')
        elif d == '6':
            ans.append('5')
            ans.append('3')
        elif d == '7':
            ans.append('7')
        elif d == '8':
            ans.append('7')
            ans.append('2')
            ans.append('2')
            ans.append('2')
        elif d == '9':
            ans.append('7')
            ans.append('3')
            ans.append('3')
            ans.append('2')

    ans.sort(reverse=True)

    print(''.join(ans))


if __name__ == '__main__':
    main()
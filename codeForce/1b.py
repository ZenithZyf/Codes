def is_rxcy(coordinate):
	if coordinate[0] == 'R' and coordinate[1] in '0123456789':
		if 'C' in coordinate:
			return True
	return False

def rxcy_to_excel(coordinate):
	dictionary = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ'
	row = coordinate[1 : coordinate.rindex('C')]
	col = int(coordinate[coordinate.rindex('C') + 1:])
	res = [row]

	while col > 0:
		col -= 1
		res = [dictionary[col % 26]] + res
		col = col // 26

	return ''.join(res)

def excel_to_rxcy(coordinate):
	dictionary = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ'
	for i in range(len(coordinate)):
		if coordinate[i] not in dictionary:
			break
	row = coordinate[i:]
	col = coordinate[:i]
	res = 'R' + row + 'C'

	t = 0
	for c in col:
		t = t * 26 + dictionary.index(c) + 1
	res += str(t)

	return res

ans = []

for _ in range(int(input())):
	coordinate = input()
	if is_rxcy(coordinate):
		ans.append(rxcy_to_excel(coordinate))
	else:
		ans.append(excel_to_rxcy(coordinate))

print('\n'.join(ans))
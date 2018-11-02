S0 = []
T0 = []

for i in range(len(S)):
    if S[i] != '#':
        S0.append(S[i])
    else:
        if S0 != []:
            S0.pop()

for j in range(len(T)):
    if T[j] != '#':
        T0.append(T[j])
    else:
        if T0 != []:
            T0.pop()

return S0 == T0
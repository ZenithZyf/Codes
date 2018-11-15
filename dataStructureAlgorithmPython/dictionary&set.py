# hash set and hash table

# set is collection of unique elements
# hash set is a set of pairs: say dictionary {}
money = {'Eghbal':40000, 'Yifeng':20000, 'Shihab':10000}

# access the items
money['Eghbal']
money['meng'] # returns KeyError
money.get('Shihab') # returns 40000
money.get('meng') # returns None
money.get('Shihab',30) # returns 40000
money.get('meng',30) # returns 30

len(money)

'Shihab' in money
'Xiandong' not in money

# update or add new values
money['Shihab'] = 15000
money['Xiandong'] = 50000

# dictionary property
money.keys() # list?
money.values() # list?
money.items() # list of list

# set
set()
a = [1,3,5,3,2,7,1,8]
set(a)

# set properties
s1 = {1,2,3}
s2 = {1,3,5}
# union
s1|s2 # {1,2,3,5}
s1&s2 # {1,3}
s1-s2 # {2}
s1^s2 # {2,5}

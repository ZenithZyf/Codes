# list
a = ['a',1,2]
# append element at end
a.append(5)
# indexing: positive, negative
a[1]
a[-1]
# insert
a.insert(2,10)
# remove and return the last element
a.pop()
# remove certain first element
# example: remove the first '2'
a.remove(2)

# shallow copy
a = [1,2,3]
b = a
b[1] = 100
# print(a): [1,100,3]
# deep copy
import copy
b = copy.deepcopy(a)
b[1] = 20
# print(a): [1,100,3]

[1,2]*3
# result in [1,2,1,2,1,2]
# creat a n size list
[0]*n

# search in list
a = [1,5,9,2]
4 in a # false
4 not in a #ture

# loop over list
for x in a
# loop over index
for i in range(len(a))

# sorting
a.sort()  # will change the original
sorted(a) # will return a sorted a
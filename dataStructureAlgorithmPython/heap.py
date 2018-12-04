# Heap

# Heaps are just simple arrays
# if parent's index is i; then child will be 2i+1 and 2i+2

# Time complexity O(log2(n))
# Insertion we should have kid number smaller than parent
# Deletion we start with the last element, swap it with the maximum, and then delete the maximum.
	# Then we start resorting the heap.

# heapq in python
a = [2,10,3,12,5,7]
# create a heap
heapq.heapify(a) # default: min heap
# insert a new value
heapq.heappush(a,15)
# pop the minimum element
heapq.heappop(a)


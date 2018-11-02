# Stack

# general idea
# put an element on the top
stack.push(value)
# remove top element and return it
stack.pop()
# return top element
stack.top()

# implementation in python
Class Stack:
	def __init__(self):
		self.a = []
	def push(value):
		self.a.append(value)
	def pop():
		return self.a.pop()
	def top():
		return self.a[-1]
	def __len__(self):
		return len(self.a)

# example:
stk = Stack()
stk.push(20)
stk.push(30)
stk.push(5)
print(stk.pop())
print(stk.top())
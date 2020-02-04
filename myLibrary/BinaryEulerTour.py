class BinaryEulerTour(EulerTour):
	"""Abstract base class for performing Euler tour of a binary tree.

	This version includes an additional _hook_invisit that is called after the tour
	of the left subtree (if any), yet before the tour of the right subtree (if any).

	Note: Right child is always assigned index 1 in path, even if no left sibling.
	"""
	def _tour(self, p, d, path):
		results = [None, None]				# will update with results of recursions
		self._hook_previsit(p, d, path)		# "pre visit" for p
		if self._tree.left(p) is not None:	# consider left child
			path.append(0)
			results[0] = self._tour(self._tree.left(p), d+1, path)
			path.pop()
		self._hook_invisit(p, d, path)		# "in visit" for p
		if self._tree.right(p) is not None:	# consider right child
			path.append(1)
			results[1] = self._tour(self._tree.right(p), d+1, path)
			path.pop()
		answer = self._hook_postvisit(p, d, path, results)	# "post visit" p
		return answer

	def _hook_invisit(self, p, d, path): pass

class BinaryLayout(BinaryEulerTour):
	"""Class for computing (x,y) coordinates for each node of a binary tree."""
	def __init__(self, tree):
		super().__init__(tree)			# must call the parent constructor
		self._count = 0					# initialize count of processed nodes

	def _hook_invisit(self, p, d, path):
		""" Assume that the element type for the original tree supports setX and setY."""
		p.element().setX(self._count)	# x-coordinate serialized by count
		p.element().setY(d)				# y-coordinate is depth
		self._count += 1
"""Several applications using tree ADT."""
def preorder_label(T, p, d, path):
	"""Print labeled representation of subtree of T rooted at p at depth d."""
	label = '.'.join(str(j+1) for j in path)	# displayed labels are one-indexed
	print(2*d*' '+label, p.element())
	path.append(0)								# path entries are zero-indexed
	for c in T.children(p):
		preorder_label(T, c, d+1, path)			# child depth is d+1
		path[-1] += 1
	path.pop()									# will have one additional element because of recursion in children

def parenthesize(T, p):
	"""Print parenthesized representation of subtree of T rooted at p."""
	print(p.element(), end='')					# use of end avoids trailing newline
	if not T.is_leaf(p):
		first_time = True
		for c in T.children(p):
			sep = ' (' if first_time else ', '	# determine proprer separator
			print(sep, end='')
			first_time = False					# any future passes will not be the first
			parenthesize(T, c)					# recur on child
		print(')', end='')						# include closing parenthesis

def disk_space(T, p):
	"""Return total disk space for subtree of T rooted at p."""
	subtotal = p.element().space()				# space used at position p
	for c in T.children(p):
		subtotal += disk_space(T, c)			# add child's spcae to subtotal
	return subtotal

class PreorderPrintIndentedTour(EulerTour):
	def _hook_previsit(self, p, d, path):
		print(2*d*' ' + str(p.element()))

# tour = PreorderPrintIndentedTour(T)
# tour.execute()

class PreorderPrintIndentedLabeledTour(EulerTour):
	def _hook_previsit(self, p, d, path):
		label = '.'.join(str(j+1) for j in path)	# labels are one-indexed
		print(2*d*' '+label, p.element())

class ParenthesizeTour(EulerTour):
	def _hook_previsit(self, p, d, path):
		if path and path[-1] > 0:				# p follows a sibling
			print(', ', end='')					# so preface with comma
		print(p.element(), end='')				# then print element
		if not self.tree().is_leaf(p):			# if p has children
			print(' (', end='')					# print opening parenthesis

	def _hook_postvisit(self, p, d, path, results):
		if not self.tree().is_leaf(p):			# if p has children
			print(')', end='')					# print closing parenthesis

class DiskSpaceTour(EulerTour):
	def _hook_postvisit(self, p, d, path, results):
		# we simply add space associated with p to that of its subtrees
		return p.element().space() + sum(results)
		
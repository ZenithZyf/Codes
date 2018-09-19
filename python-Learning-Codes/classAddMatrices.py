class Matrix(object):
	def __init__(self,array = None,rows = None,columns = None):
		if array:
			self.data = array
		else:
			self.data = [[0 for x in range(columns)] for y in range(rows)]
		self.rows    = len(self.data)
		self.columns = len(self.data[0])

	def sizeof(self):
		return (self.rows,self.columns)
	
	def __getitem__(self,i):
		return self.data[i]

	@classmethod
	def shape(cls,func,*matrices):
		rows,columns = matrices[0].sizeof()
		new = Matrix(rows = rows, columns = columns)
		for x in range(rows):
			for y in range(columns):
				new[x][y] = func(*[m[x][y] for m in matrices],x=x,y=y)
		return new

	def __add__(self,other):
		return Matrix.shape(lambda a,b,**kw:a+b, self, other)

a = Matrix([[1, 2], [3, 4]])
b = Matrix([[2, 2], [2, 2]])
# c=Matrix(a.data)
c=a+b
# c.print()
print(c)
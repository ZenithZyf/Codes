class UnionFind(object):
    def __init__(self, board, m, n):
        self.parent = [-1] * (m*n+1)
        self.rootNo = [0] * (m*n+1)
        for i in xrange(m):
            for j in xrange(n):
                if board[i][j] == 'O':
                    self.parent[i*n+j] = i*n+j

    def add(self, i):
        self.parent[i] = i
        self.rootNo[i] = 0

    def find(self, i):
        if self.parent[i] != i:
            self.parent[i] = self.find(self.parent[i])
        return self.parent[i]

    def is_connected(self, i, j):
        return self.find(i) == self.find(j)

    def union(self, x, y):
        rootx = self.find(x)
        rooty = self.find(y)
        if rootx != rooty:
            if self.rootNo[rootx] > self.rootNo[rooty]:
                self.parent[rooty] = rootx
            elif self.rootNo[rootx] < self.rootNo[rooty]:
                self.parent[rootx] = rooty
            else:
                self.parent[rooty] = rootx
                self.rootNo[rootx] += 1
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

class Solution(object):
    def notBorder(self, board, x, y):
        m, n = len(board), len(board[0])
        if x<0 or y<0 or x>=m or y>=n:
            return False
        return True

    def solve(self, board):
        """
        :type board: List[List[str]]
        :rtype: void Do not return anything, modify board in-place instead.
        """

        if not board or not board[0]:
            return
        
        dirs = [(0,1), (1,0)]
        m, n = len(board), len(board[0])
        extra = m*n
        go = UnionFind(board, m, n)
        go.add(extra)

        for y in xrange(m):
            if board[y][0] == 'O':
                go.union(y*n, extra)
            if board[y][n-1] == 'O':
                go.union(y*n+n-1, extra)

        for x in xrange(n):
            if board[0][x] == 'O':
                go.union(x, extra)
            if board[m-1][x] == 'O':
                go.union((m-1)*n+x, extra)

        for y in xrange(m):
            for x in xrange(n):
                if board[y][x] == 'O':
                    for d in dirs:
                        dd, dr = y+d[0], x+d[1]
                        if self.notBorder(board, dd, dr) and board[dd][dr] == 'O':
                            go.union(y*n+x, dd*n+dr)

        for y in xrange(m):
            for x in xrange(n):
                if board[y][x] == 'O' and go.is_connected(y*n+x, extra):
                    board[y][x] = 'O'
                else:
                    board[y][x] = 'X'


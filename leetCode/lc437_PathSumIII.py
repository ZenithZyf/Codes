# Definition for a binary tree node.
# class TreeNode:
#     def __init__(self, x):
#         self.val = x
#         self.left = None
#         self.right = None

class Solution:
    def pathSum(self, root, sum):
        """
        :type root: TreeNode
        :type sum: int
        :rtype: int
        """
        self.result = 0
        record = {0:1}
        self.dfs(root, sum, 0, record)
        
        return self.result
        
        
    def dfs(self, root, sum, currPath, record):
        if not root:
            return
        
        currPath += root.val
        oldPath  = currPath - sum
        self.result += record.get(oldPath,0)
        record[currPath] = record.get(currPath,0) + 1
        
        self.dfs(root.left, sum, currPath, record)
        self.dfs(root.right, sum, currPath, record)
        record[currPath] -= 1
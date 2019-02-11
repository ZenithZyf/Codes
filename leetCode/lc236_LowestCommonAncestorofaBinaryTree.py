# Definition for a binary tree node.
# class TreeNode:
#     def __init__(self, x):
#         self.val = x
#         self.left = None
#         self.right = None

class Solution:
    def __init__(self):
        self.judge = None
    
    def lowestCommonAncestor(self, root, p, q):
        """
        :type root: TreeNode
        :type p: TreeNode
        :type q: TreeNode
        :rtype: TreeNode
        """
        def dfs(kk):
            
            if not kk:
                return False

            left = dfs(kk.left)
            right = dfs(kk.right)

            mid = kk==p or kk==q

            if mid+left+right >= 2:
                self.judge = kk

            return mid or left or right
        
        dfs(root)
        return self.judge
    
        
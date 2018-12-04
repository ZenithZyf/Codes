# Definition for a binary tree node.
# class TreeNode:
#     def __init__(self, x):
#         self.val = x
#         self.left = None
#         self.right = None

class Solution:
    def allPossibleFBT(self, N):
        """
        :type N: int
        :rtype: List[TreeNode]
        """
        # if N%2 == 0:
        #     return []
        N -= 1
        if N == 0:
            return [TreeNode(0)]
        res = []
        for x in range(1,N,2):
            for left in self.allPossibleFBT(x):
                for right in self.allPossibleFBT(N-x):
                    node = TreeNode(0)
                    node.left = left
                    node.right = right
                    res += [node]    
        return res
                    
        
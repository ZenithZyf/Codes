class Solution:
    def findTarget(self, root, k):
        """
        :type root: TreeNode
        :type k: int
        :rtype: bool
        """
        if not root:
            return False
        
        def findElement(node,node_val,k):
            if not node:
                return False
            element = k-node.val
            if element in node_val:
                return True
            node_val.add(node.val)
            return findElement(node.right,node_val,k) or findElement(node.left,node_val,k)
        
        node_val = set()
        return findElement(root,node_val,k)
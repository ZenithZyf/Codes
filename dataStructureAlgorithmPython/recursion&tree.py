# recursion

# factorial function
# fibonacci function

# recursion sometimes take a lot of time;
# if we have an iterative alternative, choose the iterative methods!
# but sometimes recursive is very useful! (in binary tree)

# binary search
# find the mid and then split

# binary tree
# tree: root nodes + leaf nodes (maximum 2 children for each node)

# binary search tree
# every root node is greater than every element to its left
# 					 smaller than every element to its right
# class node:
# 	  value
# 	  node.left
#     node.right

# Tree traversal
# 1. pre-order traversal; 2. in-order traversal; 3. post-order traversal; 4. level-order traversal
# 1. root->left->right;
# 2. left->root->right;
# 3. left->right->root;
# 4. level by level.

# preorder(node root){
# 	if root == null
# 		return;
# 	// do(root)
# 	preorder(root.left)
# 	preorder(root.right)
# }

# inorder(node root){
# 	if root == null
# 		return;
# 	preorder(root.left)
# 	// do(root)
# 	preorder(root.right)
# }

# postorder(node root){
# 	if root == null
# 		return;
# 	preorder(root.left)
# 	preorder(root.right)
# 	// do(root)
# }
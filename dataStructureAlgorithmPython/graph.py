# graph

# 1. nodes; 2. edges: edges connect nodes.
#
# edges can be directed edge or undirected edge

# G(V,E)
# V - {0,1,2,3,4}
# E - mainly 2 ways:
	# adjacency matrix (easy to tell if there is an edge) | adjacency list (save space)
	# pair represent: (u,v) u: source of edge; v: destination of edge

# traversal: two main types:
	# depth first search (DFS)
	# breadth first search (BFS) - level order traversal in tree
# we need to mark visited or not:
# visited = [F,F,F,T,F,T] ...

# dfs(adjList, node){
# 	if not visited[node]:
# 		visited[node] = visited
# 		for neighbor in adjList[node]:
# 			dfs(adjList,neighbor)
# }

# while(not deque empty)
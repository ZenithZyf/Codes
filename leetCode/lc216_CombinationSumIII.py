class Solution:
    def combinationSum3(self, k, n):
        """
        :type k: int
        :type n: int
        :rtype: List[List[int]]
        """
        res = []
        self.dfs(range(1,10),k,n,0,[],res)
        return res
    
    def dfs(self,candidates,k,n,index,path,res):
        if k<0 or n<0:
            return
        if k==0 and n==0:
            res.append(path)
        for i in range(index,len(candidates)):
            self.dfs(candidates,k-1,n-candidates[i],i+1,path+[candidates[i]],res)
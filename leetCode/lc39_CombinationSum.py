def dfs(nums,target,path,index,res):
    if target<0:
        return
    elif target==0:
        res.append(path)
        return
    for i in range(index,len(nums)):
        dfs(nums,target-nums[i],path+[nums[i]],i,res)

class Solution:
    def combinationSum(self, candidates, target):
        """
        :type candidates: List[int]
        :type target: int
        :rtype: List[List[int]]
        """
        res = []
        candidates.sort()
        dfs(candidates,target,[],0,res)
        return res
        
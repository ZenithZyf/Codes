def dfs(nums,target,path,index,res):
    if target<0 or index>len(nums):
        return
    elif target==0:
        res.append(path)
        return
    for i in range(index,len(nums)):
        dfs(nums,target-nums[i],path+[nums[i]],i+1,res)

class Solution:
    def combinationSum2(self, candidates, target):
        """
        :type candidates: List[int]
        :type target: int
        :rtype: List[List[int]]
        """
        res = []
        candidates.sort()
        dfs(candidates,target,[],0,res)
        res2 = []
        for j in range(len(res)):
            if res[j] not in res2:
                res2.append(res[j])
        return res2
        
class Solution:
    def combinationSum4(self, nums, target):
        """
        :type nums: List[int]
        :type target: int
        :rtype: int
        """
        times = [1] + [0]*target
        for i in range(1,target+1):
            for num in nums:
                if i>=num:
                    times[i] += times[i-num]
        return times[-1]
        
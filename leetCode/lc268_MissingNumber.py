class Solution:
    def missingNumber(self, nums):
        """
        :type nums: List[int]
        :rtype: int
        """
        n = len(nums)
        s = n*(n+1)//2
        for num in nums:
            s -= num
        return s
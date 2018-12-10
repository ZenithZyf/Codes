class Solution(object):
    def maxSlidingWindow(self, nums, k):
        """
        :type nums: List[int]
        :type k: int
        :rtype: List[int]
        """
        if len(nums) == 0 or len(nums) - k < 0:
            return []
        
        ans = [0] * (len(nums) - k + 1)
        
        last_maximum_index = -1
        
        for i in range(len(nums) - k + 1):
            if last_maximum_index < i:
                last_maximum_index = i
                for j in range(i, i+k):
                    if nums[j] > nums[last_maximum_index]:
                        last_maximum_index = j
            else:
                if nums[last_maximum_index] < nums[i + k - 1]:
                    last_maximum_index = i + k - 1
            ans[i] = nums[last_maximum_index]
        return ans
        
        
        
        
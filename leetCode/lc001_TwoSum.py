class Solution:
    def twoSum(self, nums, target):
        """
        :type nums: List[int]
        :type target: int
        :rtype: List[int]
        """
        index = []
        k = len(nums)-1
        if not nums:
            return None
        else:
            for i in range(len(nums)):
                digit = nums.pop()
                diffe = target - digit
                if diffe in nums:
                    index.append(k)
                    break
                k -= 1
            k -= 1
            for j in range(len(nums)):
                if nums[j] == diffe:
                    index.append(j)
                    break
        return index[::-1]
                
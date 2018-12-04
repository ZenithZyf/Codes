def recur(nums,target,left,right):
    if left <= right:
        mid = (left+right)//2
        if nums[mid] == target:
            return mid
        elif nums[mid] < target:
            return recur(nums,target,mid+1,right)
        elif nums[mid] > target:
            return recur(nums,target,left,mid-1)
    else: return -1

class Solution:
    def search(self, nums, target):
        """
        :type nums: List[int]
        :type target: int
        :rtype: int
        """

        left,right = 0,len(nums)-1
        return recur(nums,target,left,right)
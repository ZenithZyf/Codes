class Solution:
    def containsNearbyDuplicate(self, nums, k):
        """
        :type nums: List[int]
        :type k: int
        :rtype: bool
        """
        check = {}
 		for i, v in enumerate(nums):
 			if v in check and i-check[v]<=k:
 				return True
 			check[v] = i
 		return False
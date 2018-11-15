class Solution:
    def intersect(self, nums1, nums2):
        """
        :type nums1: List[int]
        :type nums2: List[int]
        :rtype: List[int]
        """
        if len(nums1) > len(nums2):
        	nums1, nums2 = nums2, nums1
        k = len(nums1)
        nums3 = []

        for i in range(k):
        	for j in range(len(nums2)):
        		if nums2[j] == nums1[i]:
        			nums3.append(nums2[j])
        			del nums2[j]
        			break

        return nums3
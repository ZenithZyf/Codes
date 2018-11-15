class Solution:
    def intersection(self, nums1, nums2):
        """
        :type nums1: List[int]
        :type nums2: List[int]
        :rtype: List[int]
        """
        nums1 = set(nums1)
        inter = []
        
        for i in range(len(nums2)):
            if nums2[i] in nums1:
                inter.append(nums2[i])
        
        return list(set(inter))
        
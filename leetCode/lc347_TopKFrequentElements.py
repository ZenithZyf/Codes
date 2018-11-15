class Solution:
    def topKFrequent(self, nums, k):
        """
        :type nums: List[int]
        :type k: int
        :rtype: List[int]
        """
        word_count = {}
        for i in nums:
            word_count[i] = word_count.get(i,0) + 1
        word_sorted = sorted(word_count.items(), key=lambda x:x[1], reverse=True)
        rank = []
        for n in range(k):
            rank.append(word_sorted[n][0])
        return rank
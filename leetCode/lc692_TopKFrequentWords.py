from collections import Counter
class Solution(object):
    def topKFrequent(self, words, k):
        """
        :type words: List[str]
        :type k: int
        :rtype: List[str]
        """
        count = Counter(words)
        word_list = count.keys()
        word_list.sort(key = lambda x: (-count[x], x))
        # print(word_list)
        return word_list[:k]
        
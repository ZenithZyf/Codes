import re
from collections import Counter
class Solution:
    def mostCommonWord(self, paragraph, banned):
        """
        :type paragraph: str
        :type banned: List[str]
        :rtype: str
        """
        wordCount = collections.defaultdict()
        words = re.sub("[^\w]"," ",paragraph.lower()).split()
        wordCount = Counter(words).most_common()
        
        # print(wordCount.keys())
        # print(len(wordCount))
        deleted = 0
        for i in range(len(wordCount)):
            ii = i-deleted
            if wordCount[ii][0] in banned:
                del wordCount[ii]
                deleted += 1
        # print(wordCount)
        return wordCount[0][0]
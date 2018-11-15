class Solution:
    def findAnagrams(self, s, p):
        """
        :type s: str
        :type p: str
        :rtype: List[int]
        """
        from collections import Counter

        pC = Counter(p)
        sC = Counter(s[:len(p)-1])
        index = []
        
        for i in range(len(p)-1,len(s)):
            sC[s[i]] += 1
            if sC == pC:
                index.append(i-len(p)+1)
            sC[s[i-len(p)+1]] -= 1
            if sC[s[i-len(p)+1]] == 0:
                del sC[s[i-len(p)+1]]
        
        return index
class Solution:
    def numJewelsInStones(self, J, S):
        """
        :type J: str
        :type S: str
        :rtype: int
        """
        J = list(J)
        jewel = set(J)
        S = list(S)
        
        count = 0
        for i in range(len(S)):
            if S[i] in jewel:
                count += 1
        return count
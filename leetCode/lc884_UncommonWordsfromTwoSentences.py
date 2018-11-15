class Solution:
    def uncommonFromSentences(self, A, B):
        """
        :type A: str
        :type B: str
        :rtype: List[str]
        """
        A = A.split()    
        B = B.split()
        
        total = A+B
        diff = []
        dictU = {}
        
        for i in total:
            if i not in dictU:
                dictU[i] = 1
            else:
                dictU[i] += 1
        for x in dictU:
            if dictU.get(x) == 1:
                diff.append(x)
        return diff
        

        
        
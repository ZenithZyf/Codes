class Solution:
    def frequencySort(self, s):
        """
        :type s: str
        :rtype: str
        """
        s = list(s)
        s.sort()
        num = 1
        k = 0
        new = []
        newstr = ''

        for i in range(len(s)-1):

            if s[i+1] == s[i]:
                num = num+1
                if i+1 == len(s)-1:
                    new.append([])
                    new[k].append(s[len(s)-1])
                    new[k].append(num)
            else:
                new.append([])
                new[k].append(s[i])
                new[k].append(num)
                k = k+1
                num = 1
                if i+1 == len(s)-1:
                    new.append([])
                    new[k].append(s[len(s)-1])
                    new[k].append(num)			

        new.sort(key=lambda x:x[1], reverse=True)

        for j in range(len(new)):
            newstr = newstr + new[j][0]*new[j][1]

        return newstr
class Solution:
    def isAnagram(self, s, t):
        """
        :type s: str
        :type t: str
        :rtype: bool
        """
        s = list(s)
        t = list(t)

        s.sort()
        t.sort()

        if s == t:
        	return True
        else:
        	return False
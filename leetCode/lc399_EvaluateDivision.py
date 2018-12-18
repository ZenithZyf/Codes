import collections
class Solution:
    def calcEquation(self, equations, values, queries):
        """
        :type equations: List[List[str]]
        :type values: List[float]
        :type queries: List[List[str]]
        :rtype: List[float]
        """
        divi = collections.defaultdict(dict)
        for (fir,sec), val in zip(equations, values):
            divi[fir][fir] = divi[sec][sec] = 1.0
            divi[fir][sec] = val
            divi[sec][fir] = 1/val
        for i,j,m in itertools.permutations(divi,3):
            if i in divi[j] and m in divi[i]:
                divi[j][m] = divi[j][i]*divi[i][m]
        return [divi[fir].get(sec, -1.0) for fir,sec in queries]
        
        
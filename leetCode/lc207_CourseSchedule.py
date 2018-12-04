class Solution(object):
    def canFinish(self, numCourses, prerequisites):
        """
        :type numCourses: int
        :type prerequisites: List[List[int]]
        :rtype: bool
        """
        req_Course = [[] for i in range(numCourses)]
        required = [0]*numCourses
        for j,i in prerequisites:
            req_Course[i].append(j)
            required[j] += 1
        notRequired = [i for i in range(numCourses) if required[i] == 0]
        for ii in notRequired:
            for jj in req_Course[ii]:
                required[jj] -= 1
                if required[jj] == 0:
                    notRequired.append(jj)
        return len(notRequired) == numCourses
                
        
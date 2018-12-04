import heapq
class Solution(object):
    def networkDelayTime(self, times, N, K):
        """
        :type times: List[List[int]]
        :type N: int
        :type K: int
        :rtype: int
        """
        pair, time_record = [(0,K)], {}
        edgeTime = collections.defaultdict(list)
        for ii, jj, kk in times:
            edgeTime[ii].append((jj,kk))
        while pair:
            time, node = heapq.heappop(pair)
            if node not in time_record:
                time_record[node] = time
                for mm, nn in edgeTime[node]:
                    heapq.heappush(pair, (time+nn, mm))
        return max(time_record.values()) if len(time_record) == N else -1
class Solution(object):
    def findItinerary(self, tickets):
        """
        :type tickets: List[List[str]]
        :rtype: List[str]
        """
        connection = collections.defaultdict(list)
        for dep, arr in sorted(tickets)[::-1]:
            connection[dep] += arr,
        travel = []
        # return connection
        def goto(airport):
            while connection[airport]:
                goto(connection[airport].pop())
            travel.append(airport)
        goto("JFK")
        return travel[::-1]
class Solution:
    def canVisitAllRooms(self, rooms):
        """
        :type rooms: List[List[int]]
        :rtype: bool
        """
        access = set()
        
        record = []
        record.append(0)
        
        while record:
            check = record.pop()
            if check not in access:
                access.add(check)
                record = record + rooms[check]
        
        return len(access)==len(rooms)
        
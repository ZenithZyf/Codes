class MinStack:

    def __init__(self):
        """
        initialize your data structure here.
        """
        self._data = []
        self.localmin = float('inf')
        

    def push(self, x: int) -> None:
        self._data.append(x-self.localmin)
        if x-self.localmin < 0:
            self.localmin = x
        

    def pop(self) -> None:
        if not self._data:
            return
        temp = self._data.pop()
        if temp < 0:
            self.localmin -= temp
        return temp
        

    def top(self) -> int:
        if not self._data:
            return
        if self._data[-1]>=0:
            return self._data[-1]+self.localmin
        else:
            return self.localmin
        
        
    def getMin(self) -> int:
        return self.localmin
        


# Your MinStack object will be instantiated and called as such:
# obj = MinStack()
# obj.push(x)
# obj.pop()
# param_3 = obj.top()
# param_4 = obj.getMin()
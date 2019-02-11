from functools import reduce
class Solution:
    def singleNumber(self, nums):
        """
        :type nums: List[int]
        :rtype: List[int]
        """
        xor = reduce(operator.xor,nums)
        ans = reduce(operator.xor, (x for x in nums if x&xor&-xor))
        return [ans, ans^xor]
        
start = ["(","[","{"]
close = [")","]","}"]
stack = []

for char in s:
    if char in close:
        top = stack.pop() if stack else 'f'
        if char == ")":
            if top != start[0]:
                return False
        elif char == "]":
            if top != start[1]:
                return False
        elif char == "}":
            if top != start[2]:
                return False
    else:
        stack.append(char)

return not stack
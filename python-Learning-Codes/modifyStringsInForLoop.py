words = ['cat','window','lpy']
for w in words[:]:
	if len(w)>4:
		words.insert(0,w)
print(words)

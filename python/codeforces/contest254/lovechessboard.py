#!/usr/bin/python 
IN = lambda: raw_input()
#f = open("in.txt")
#IN = lambda: f.readline()
I = lambda: map(int, IN().split())

R = lambda x: x%2
n, m = I()
S = [["-" for x in range(m)] for y in range(n)]
for i in range(n):
	t = str(IN().strip())
	for j in range(m):
		if t[j] == '.':
			if (R(i) and R(j)) or (not R(i) and not R(j)):
				S[i][j] = 'B'
			else:
				S[i][j] = 'W'
for i in range(n):
	print ''.join(S[i])

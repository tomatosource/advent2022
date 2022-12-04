count = 0
for line in io.open("./input.txt", "r"):lines() do
	s1Str, e1Str, s2Str, e2Str = line:match("^(%d+)-(%d+),(%d+)-(%d+)$")
	s1, e1, s2, e2 = tonumber(s1Str), tonumber(e1Str), tonumber(s2Str), tonumber(e2Str)
	if (s1<=s2 and e1 >= e2) or (s2<=s1 and e2>=e1) then count = count + 1 end
end
print(count)

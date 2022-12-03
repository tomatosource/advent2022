# awk

```
awk 'BEGIN {s=0;m=0;} NF > 0 { s+= $1 } NF < 1 { if (s>m) m=s;s=0 } END { print (s>m?s:m) }' input.txt
```

```
# init s(um) and m(ax) to zero
BEGIN {s=0;m=0;}
# if there is a field add it to current sum
NF > 0 { s+= $1 }
# if its a blank line
NF < 1 {
  # if current sum is bigger than max
	if (s>m)
		# update max to sum
		m=s;
	# reset current sum
	s=0
}
# print the larger of s and m (to check last group)
END { print (s>m?s:m) }
```

BEGIN {s=0;m=0;} NF > 0 { s+= $1 } NF < 1 { if (s>m) m=s;s=0 } END { print (s>m?s:m) }

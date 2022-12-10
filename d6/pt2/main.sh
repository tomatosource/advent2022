CHUNK_SIZE=14
for (( block = 0; block < 4096; block += 1 ))
do
	CHUNK=`dd if=input.txt skip=${block} bs=1 count=${CHUNK_SIZE} 2> /dev/null`
	MAX_COUNT=`echo ${CHUNK} | grep -o . | sort | uniq -c | sort -r | head -n1`
	if [[ "$MAX_COUNT" == *"1"* ]]; then
		echo $((${block}+${CHUNK_SIZE}))
		exit
	fi
done

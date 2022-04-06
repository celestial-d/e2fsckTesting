#/bin/bash
#
count=0
IFS=$'\n\n'
for line in `cat option`;
do
	echo "$line"
	echo "\n"
	sleep 1
	dd if=/dev/zero of=test.img bs=1k count=100000
	mke2fs -t ext4 $line test.img
	e2fsck -y test.img
	resize2fs -f test.img 500M
	e2fsck -y test.img
	rm test.img
done	

#/bin/bash
#
count=0
IFS=$'\n\n'
for line in `cat option`;
do
	sleep 1
	c="mke2fs -t ext4 $line test.img"
	echo "####################################"
	echo $c
	echo "############################### "
	echo ''
	dd if=/dev/zero of=test.img bs=1k count=100000
	eval $c
	sleep 1
	e2fsck -y test.img
	resize2fs -f test.img 500M
	e2fsck -y test.img
	rm test.img
done	

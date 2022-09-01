#/bin/bash
#
#./test.sh 2>&1|tee log
count=0
IFS=$'\n\n'
for line in `cat option`;
do
	sleep 1
	c="mke2fs -t ext4 $line test.img"
	echo "####################################"
	echo $c
	echo "############################### "
	echo "!!!!dd if=/dev/zero of=test.img bs=1k count=100000!!!!"
	dd if=/dev/zero of=test.img bs=1k count=100000
	echo "!!!!mkfe2fs!!!!"
	if eval $c; then
		sleep 1
		echo "!!!!e2fsck !!!!"
		e2fsck -y test.img
		echo "!!!!resize2fs -f test.img 500M!!!!"
		resize2fs -f test.img 500M
		echo "!!!!e2fsck !!!!"
		e2fsck -y test.img
	fi
	rm test.img
done	

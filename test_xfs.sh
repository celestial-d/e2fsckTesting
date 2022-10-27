#/bin/bash
#
#./test.sh 2>&1|tee log
count=0
IFS=$'\n\n'
for line in `cat optionxfs`;
do
	sleep 1
	c="mkfs.xfs $line test.img"
	echo "####################################"
	echo $c
	echo "############################### "
	echo "!!!!dd if=/dev/zero of=test.img bs=1k count=100000!!!!"
	dd if=/dev/zero of=test.img bs=1k count=400000
	echo "!!!!mkfs_xfs!!!!"
	if eval $c; then
		sleep 1
		echo "!!!!xfs_repair !!!!"
		xfs_repair test.img
		#echo "!!!!resize2fs -f test.img 500M!!!!"
		#resize2fs -f test.img 500M
		#echo "!!!!e2fsck !!!!"
		#e2fsck -y test.img
	fi
	rm test.img
done	

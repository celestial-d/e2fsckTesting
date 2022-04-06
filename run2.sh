#/bin/bash
#
count=0
IFS=$'\n\n'

echo "-O extent,64bit"
	echo "\n"
	sleep 1
	dd if=/dev/zero of=test.img bs=1k count=100000
	mke2fs -t ext4 -O extent,64bit test.img
	e2fsck -y test.img
	resize2fs -f test.img 1500M
	e2fsck -y test.img
	rm test.img
	
	echo "-O extent,bigalloc"
	echo "\n"
	sleep 1
	dd if=/dev/zero of=test.img bs=1k count=100000
	mke2fs -t ext4 -O extent,bigalloc test.img
	e2fsck -y test.img
	resize2fs -f test.img 1500M
	e2fsck -y test.img
	rm test.img
	
	echo "-O inline_data -I 128"
	echo "\n"
	sleep 1
	dd if=/dev/zero of=test.img bs=1k count=100000
	mke2fs -t ext4 -O inline_data -I 128 test.img
	e2fsck -y test.img
	resize2fs -f test.img 1500M
	e2fsck -y test.img
	rm test.img
	
	echo "-O meta_bg,^resize_inode -r 1"
	echo "\n"
	sleep 1
	dd if=/dev/zero of=test.img bs=1k count=100000
	mke2fs -t ext4 -O meta_bg,^resize_inode -r 1 test.img
	e2fsck -y test.img
	resize2fs -f test.img 1500M
	e2fsck -y test.img
	rm test.img
	
	echo "-O resize_inode,sparse_super"
	echo "\n"
	sleep 1
	dd if=/dev/zero of=test.img bs=1k count=100000
	mke2fs -t ext4 -O resize_inode,sparse_super test.img
	e2fsck -y test.img
	resize2fs -f test.img 1500M
	e2fsck -y test.img
	rm test.img
	
	echo "-O resize_inode,64bit"
	echo "\n"
	sleep 1
	dd if=/dev/zero of=test.img bs=1k count=100000
	mke2fs -t ext4 -O resize_inode,64bit test.img
	e2fsck -y test.img
	resize2fs -f test.img 1500M
	e2fsck -y test.img
	rm test.img
	
	echo "-O 64bit ... 64"
	echo "\n"
	sleep 1
	dd if=/dev/zero of=test.img bs=1k count=100000
	mke2fs -t ext4 -O 64bit test.img 64
	e2fsck -y test.img
	resize2fs -f test.img 1500M
	e2fsck -y test.img
	rm test.img
	
	echo "-O 64bit -b 4096"
	echo "\n"
	sleep 1
	dd if=/dev/zero of=test.img bs=1k count=100000
	mke2fs -t ext4 -O 64bit -b 4096 test.img
	e2fsck -y test.img
	resize2fs -f test.img 1500M
	e2fsck -y test.img
	rm test.img
	
	echo "-O 64bit -i 5000"
	echo "\n"
	sleep 1
	dd if=/dev/zero of=test.img bs=1k count=100000
	mke2fs -t ext4 -O 64bit -i 5000 test.img
	e2fsck -y test.img
	resize2fs -f test.img 1500M
	e2fsck -y test.img
	rm test.img
	
	echo "-O 64bit -N 65536"
	echo "\n"
	sleep 1
	dd if=/dev/zero of=test.img bs=1k count=100000
	mke2fs -t ext4 -O 64bit -N 65536 test.img
	e2fsck -y test.img
	resize2fs -f test.img 1500M
	e2fsck -y test.img
	rm test.img
	
	echo "-O bigalloc -b 4096"
	echo "\n"
	sleep 1
	dd if=/dev/zero of=test.img bs=1k count=100000
	mke2fs -t ext4 -O bigalloc -b 4096 test.img
	e2fsck -y test.img
	resize2fs -f test.img 1500M
	e2fsck -y test.img
	rm test.img
	
	echo "-O bigalloc -C 16384"
	echo "\n"
	sleep 1
	dd if=/dev/zero of=test.img bs=1k count=100000
	mke2fs -t ext4 -O bigalloc -C 16384 test.img
	e2fsck -y test.img
	resize2fs -f test.img 1500M
	e2fsck -y test.img
	rm test.img
	
	echo "-O flex_bg -G 512"
	echo "\n"
	sleep 1
	dd if=/dev/zero of=test.img bs=1k count=100000
	mke2fs -t ext4 -O flex_bg -G 512 test.img
	e2fsck -y test.img
	resize2fs -f test.img 1500M
	e2fsck -y test.img
	rm test.img
	
	echo "-O bigalloc -b 4096 -C 16384"
	echo "\n"
	sleep 1
	dd if=/dev/zero of=test.img bs=1k count=100000
	mke2fs -t ext4 -O bigalloc -b 4096 -C 16384 test.img
	e2fsck -y test.img
	resize2fs -f test.img 1500M
	e2fsck -y test.img
	rm test.img
	
	echo "-b 4096 ... 64"
	echo "\n"
	sleep 1
	dd if=/dev/zero of=test.img bs=1k count=100000
	mke2fs -t ext4 -b 4096 test.img 64
	e2fsck -y test.img
	resize2fs -f test.img 1500M
	e2fsck -y test.img
	rm test.img
	
	echo "-b 4096 -i 5000"
	echo "\n"
	sleep 1
	dd if=/dev/zero of=test.img bs=1k count=100000
	mke2fs -t ext4 -b 4096 -i 5000 test.img
	e2fsck -y test.img
	resize2fs -f test.img 1500M
	e2fsck -y test.img
	rm test.img
	
	echo "-b 4096 -I 128"
	echo "\n"
	sleep 1
	dd if=/dev/zero of=test.img bs=1k count=100000
	mke2fs -t ext4 -b 4096 -I 128 test.img
	e2fsck -y test.img
	resize2fs -f test.img 1500M
	e2fsck -y test.img
	rm test.img
	
	echo "-b 4096 -N 32"
	echo "\n"
	sleep 1
	dd if=/dev/zero of=test.img bs=1k count=100000
	mke2fs -t ext4 -b 4096 -N 32 test.img
	e2fsck -y test.img
	resize2fs -f test.img 1500M
	e2fsck -y test.img
	rm test.img
	
	echo "-b 4096 -r 1"
	echo "\n"
	sleep 1
	dd if=/dev/zero of=test.img bs=1k count=100000
	mke2fs -t ext4 -b 4096 -r 1 test.img
	e2fsck -y test.img
	resize2fs -f test.img 1500M
	e2fsck -y test.img
	rm test.img
	
	echo "-O journal_dev -m 50"
	echo "\n"
	sleep 1
	dd if=/dev/zero of=test.img bs=1k count=100000
	mke2fs -t ext4 -O journal_dev -m 50 test.img
	e2fsck -y test.img
	resize2fs -f test.img 1500M
	e2fsck -y test.img
	rm test.img
	
	echo "-O meta_bg,resize_inode"
	echo "\n"
	sleep 1
	dd if=/dev/zero of=test.img bs=1k count=100000
	mke2fs -t ext4 -O meta_bg,resize_inode test.img
	e2fsck -y test.img
	resize2fs -f test.img 1500M
	e2fsck -y test.img
	rm test.img
	
	echo "-O uninit_bg,metadata_csum"
	echo "\n"
	sleep 1
	dd if=/dev/zero of=test.img bs=1k count=100000
	mke2fs -t ext4 -O uninit_bg,metadata_csum test.img
	e2fsck -y test.img
	resize2fs -f test.img 1500M
	e2fsck -y test.img
	rm test.img
	
	echo "-O metadata_csum,metadata_csum_seed"
	echo "\n"
	sleep 1
	dd if=/dev/zero of=test.img bs=1k count=100000
	mke2fs -t ext4 -O metadata_csum,metadata_csum_seed test.img
	e2fsck -y test.img
	resize2fs -f test.img 1500M
	e2fsck -y test.img
	rm test.img
	
	echo "-O metadata_csum,^metadata_csum_seed"
	echo "\n"
	sleep 1
	dd if=/dev/zero of=test.img bs=1k count=100000
	mke2fs -t ext4 -O metadata_csum,^metadata_csum_seed test.img
	e2fsck -y test.img
	resize2fs -f test.img 1500M
	e2fsck -y test.img
	rm test.img
	
	echo "-O meta_bg,^resize_inode -r 1"
	echo "\n"
	sleep 1
	dd if=/dev/zero of=test.img bs=1k count=100000
	mke2fs -t ext4 -O meta_bg,^resize_inode -r 1 test.img
	e2fsck -y test.img
	resize2fs -f test.img 1500M
	e2fsck -y test.img
	rm test.img
	
	echo "-O ^metadata_csum,metadata_csum_seed"
	echo "\n"
	sleep 1
	dd if=/dev/zero of=test.img bs=1k count=100000
	mke2fs -t ext4 -O ^metadata_csum,metadata_csum_seed test.img
	e2fsck -y test.img
	resize2fs -f test.img 1500M
	e2fsck -y test.img
	rm test.img
	
	

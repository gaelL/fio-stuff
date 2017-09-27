# fio-stuff

fio stuff from everywere and other note about disk benchmark

Random links :

  * http://fio.readthedocs.io/en/latest/fio_doc.html#examples
  * https://tobert.github.io/post/2014-04-17-fio-output-explained.html
  * https://github.com/ivotron/docker-fio/tree/master/examples
  * https://github.com/giantswarm/filesystem-benchmark/tree/master/fio


```
$ dd if=/dev/zero of=/mnt/lol bs=1G count=1 oflag=direct
$ dd if=/dev/zero of=/mnt/lol bs=4M count=250 oflag=direct
$ sudo bonnie++ -s 8192 -r 4096 -u root -d /mnt/ -m BenchClient


sudo fio --filename=/dev/sda --direct=1 --sync=1 --rw=write --bs=4k --numjobs=1 --iodepth=1 --runtime=60 --time_based --group_reporting --name=journal-test

# 50% read/write
fio --filename=/dev/xvdf --direct=1 --rw=randrw --rwmixwrite=50 --refill_buffers --norandommap --randrepeat=0 --ioengine=libaio --bs=128k --rate_iops=1280  --iodepth=16 --numjobs=1 --time_based --runtime=86400 --group_reporting --name=benchtest --size=128

# 95% or reads (5% of write)
fio --filename=/dev/xvdf --direct=1 --rw=randrw --rwmixwrite=5 --refill_buffers --norandommap --randrepeat=0 --ioengine=libaio --bs=128k --rate_iops=1280  --iodepth=16 --numjobs=1 --time_based --runtime=86400 --group_reporting --name=benchtest --size=128
```

```
docker info | grep Driver

docker run -it gaell/fio-stuff

docker run -it -v /mnt:/mnt gaell/fio-stuff fio samples/random_rw.fio

docker run --rm -it  gaell/fio-stuff fio official/ssd-test.fio --directory=/mnt/ --runtime=120
docker run --rm -it -v /var/lib/docker:/mnt gaell/fio-stuff fio official/ssd-test.fio --directory=/mnt/ --runtime=120

# Not tested yet
docker run -it -v /var/lib/docker:/mnt gaell/fio-stuff fio official/latency-profile.fio --filename=/mnt/foo  --runtime=120 --size=1G
docker run -it -v /var/lib/docker:/mnt gaell/fio-stuff fio official/tiobench-example.fio  --runtime=120
```

```
## docker config

# Overlayfs2
vim /run/flannel/flannel_docker_opts.env
DOCKER_OPTS="--storage-driver overlay2"

# Devicemapper thinpool lvm
pvcreate /dev/md127
vgcreate vg001 /dev/md127
lvcreate -L 100G -T vg001/thinpool
DOCKER_OPTS="--storage-driver devicemapper --storage-opt=dm.use_deferred_deletion=true --storage-opt=dm.use_deferred_removal=true --storage-opt=dm.thinpooldev=/dev/mapper/vg001-thinpool"
```

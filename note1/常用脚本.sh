#！/bin/bash

$0: 脚本本身文件名称
$1: 命令行第一个参数，$2为第二个，以此类推
$*: 所有参数列表
$@: 所有参数列表  #被双引号(" ")包含时，与 $* 稍有不同
$#: 参数个数
$$: 脚本运行时的PID
$?: 脚本退出码

//把bak.txt修改为/b_iscsi/http/webs/webs/doc/ui/css/ui.css.bak
sed -i 's/bak.txt/\/b_iscsi\/http\/webs\/webs\/doc\/ui\/css\/ui.css.bak/g' try.sh.bak

//匹配到指定的字符串所在记录，并打印该字符串所在的字段
cat data1.txt | awk '{for(i=1;i<=NF;i++) if($i ~ /(1-9:64:)/)  print $i }' 
results=`echo $line1|awk '{for(i=1;i<=NF;i++) if($i ~ /'-$disk_id:$seg_no:'/)  print $i}'|awk -F "-" '{print $2}'`

//多个字段赋值给多个变量
read a b c < <( cat checkinfo.txt | awk '{print $1,$2,$3}')
echo "$a $b $c"
 
//OFS参数使用
 cat /etc/passwd|awk -F: '{OFS="...";print $1,$2}'

//去除重复seg信息
sort -t":" -k2n 444.txt| awk '{if ($0!=line) print;line=$0}' >555.txt
cat checkinfo.log|awk '{print $1,$2,$3,$4,$5}'|sort -t":" -k2n| awk '{if ($0!=line) print;line=$0}' > 666.txt

bcli iraid metainfo 1|grep "^Mraid"|head -n 20|awk '{print $5,$6}'

//循环
list=`echo {1..12}`;for node in $list ;do bcli iraid metainfo $node |grep  "2-242:3597" ; done
for ((i=1;i<=12;i++)); do echo $i;bcli ;done


:<<!
count_faultyseg=`echo $line1|awk 'BEGIN{count=0} {for(i=1;i<=NF;i++) if($i ~ /([F])/) count++ fi; print count}'`
count_removeseg=`echo $line1 | awk 'BEGIN{count=0} {for(i=1;i<=NF;i++) if($i ~ /(.-0:0::)/) count++ fi;print count}'`
!

cat /proc/iraid/md$iraid_id/metainfo|grep ".-$disk_id:$seg_no:"|while read line1
bcli iraid metainfo $iraid_id|grep ".-$disk_id:$seg_no:"|while read line1

disk_id=19
seg_no=1

cat /home/wangzhe/log.log|head -1 |awk '
{
        print gensub(/-||Mraid/," ","g",$1)
        for(i=1;i<=NF;i++)
        {
            if($i ~ /'1-$disk_id:$seg_no::'/)
                print gensub(/::/," ",1,$i)
        }       
}'

去除重复行 
sort file |uniq
查找非重复行 
sort file |uniq -u
查找重复行 
sort file |uniq -d
统计 
sort file |uniq -c

一列求和
awk '{sum += $1};END {print sum}'

#磁盘检测超时
count=0
status=`/b_iscsi/bin/report_all_scsi_device_info -d|grep "$disk"|awk '$10~/2[34]/{print $NF}' `
while [[ $status = "checking" ]]
do
    sleep 10
    logger -s -t raid1_bgy "$(date +%T) waiting:disk $disk checking..."
    status=`/b_iscsi/bin/report_all_scsi_device_info -d|grep "$disk"|awk '$10~/2[34]/{print $NF}' `
    let count++
    if [ $count -eq 30 ]; then
        logger -s -t raid1_bgy "disk checking timeout(5min)"
        exit 1
    fi
done



cat /b_iscsi/http/web/global.php | grep "enable_make_maintain_log =" >& /dev/null; if [ $? -ne 0 ]; then sed -i "s/^\$enable_shot = .*$/&\n\n#2004界面允许分层日志下载，1 为使用分层下载， 0 为使用原来的日志下载\n\$enable_make_maintain_log = 1; /" /b_iscsi/http/web/global.php; fi 

cat /home/wangzhe/ | grep "smart_product_model =" >& /dev/null;
if [ $? -ne 0 ]; then
    sed -i "s/^\$smart_product_model = .*$/&\n\n#智慧社区单盘模式UI开关设置，1:单盘模式(默认)，0:iRAID模式\n\$single_disk_mode = 1; /" /home/wangzhe/global.php.bak;
fi


j=`cat info.log |grep MemFree |grep 2019-07-06|wc -l`;k=`cat info.log |grep MemFree |grep 2019-07-06|awk '{sum += $4};END {print sum}'`;echo $((i=$k/$j));

j=`cat iostat.log |grep -A1 idle|grep -v avg-cpu |grep 2019-07-06|awk '{print $NF}'|wc -l`;k=`cat iostat.log |grep -A1 idle|grep -v avg-cpu |grep 2019-07-06|awk '{sum += $NF};END {print sum}'`;var1=`echo "scale=4; $k/$j" | bc`;echo $var1;



ls /etc/iraid/driver/local/3/3_* |sort -n -t "_" -k2

ls /etc/iraid/driver/local/3/3_* |awk -F "_" '{print $NF}'|sort -n



echo "/usr/bin/bzcat /etc/iraid/iraid-meta/active/666.meta.0.bz2"| sed 's/.*\/(.*)\.meta.*/\1/'

awk '{printf "%5d MB %s\n", $3*$4/(1024*1024), $1}' < /proc/slabinfo | sort -n


海光流媒体
42.52
administrator 密码hik12345+


mount -t cifs -o user=yuzhiqiang5 //10.192.44.24/ /code/ 

rsync  --inplace 参数

/dom/storoswd/docker/TOOLS/get_biriad_size 

快照可以单独作为一份可以读取的副本，但并没有像简单的镜像那样，一开始就占用了和源卷一样大小的空间，而是根据创建快照后上层业务产生的数据，来实时占用必需的存储空间

1. 分区写入，是否会额外的引发快照写
    a. dd 写                                           否
    b. dd覆盖写                                        否
    c. 文件拷贝写
    d. 文件拷贝覆盖写

2. 快照大小
目前的快照大小为分区大小（减去初始大小）。若快照不涵盖额外数据写入（仅元数据），那快照大小应该很小即可，或者调整元数据大小即可


function check_everyseg()
{

    for iraid_id in `bcli iraid list | grep -w active | awk '{print $1}'`
    do
        #保存iraid元数据
        bcli iraid metainfo $iraid_id |grep "^Mraid" > /tmp/metainfo_$iraid_id.log
        local iraid_status=`bcli iraid info $iraid_id | grep "state_iraid" | awk '{print $NF}'`
        if [[ $iraid_status = "warning" ]];then
            echo_log "check_iraid_status:fail, iraid$iraid_id status is warning"
            #掉盘冗余内
            cat /tmp/metainfo_$iraid_id.log | while read line

            


        elif [[ $iraid_status = "disable" ]];then
            echo_log "check_iraid_status:fail, iraid$iraid_id status is disable"
            #掉盘超冗余

        fi
    done

}


pool_disk_id=`bcli pool disklist |grep -v "^#" |awk -v disk_msn_temp=$disk_msn '$8==disk_msn_temp{printf $1}'`

remove_seg_num=`echo $line|awk '{for(i=5;i<=NF;i++) print $i}'|grep "R"|wc -l`
if [[ $remove_seg_num -eq $all_seg_num ]];then
    #seg全部被remove

fi

for ((i=0;i<${#disk_conut[@]};i++))
do
    disk_msn[$i]=`echo ${disk_info[$i]}|cut -d " " -f1`
    pool_disk_id[$i]=`bcli pool disklist |grep -v "^#" |awk '{if($8~/'${disk_msn[$i]}'/) printf $1}'`
done

#数组作为参数传入函数
function showArr()
{
    echo $*
}
showArr "${pool_disk_id[*]}"


 cat crash_ps |awk '{print $NF}'|sort |uniq -c|sort -n -k 1

 HGSTHUS726T4TALE6L4.V6HWZ12R   
 /dev/sdac:HGSTHUS726T4TALE6L4.V6HSDVUR
 /dev/sdaa:HGSTHUS726T4TALE6L4.V6HSVK1R
 

修改
report_pool_info_by_poolname                strncpy((char *)pool.pool_name,pool_name,POOL_UUID_LEN);
                                            strncpy((char *)pool_balance.pool_name,pool.pool_name,POOL_NAME_LEN - 1);
pool_report_poolinfo                        char pool_name_tmp[POOL_NAME_LEN] = {0};
                                            strncpy(pool_name_tmp,pool_msg,POOL_NAME_LEN - 1);


/usr/local/lib/iraid//mod_pool: line 224: 17712 Aborted                 (core dumped) $_MEM_CHECKER $BINS/cli-pool $g_mod_debug -d info -N ALL

/root/iraid/bin/cli-pool -d start-pool -m default -Z 1 -m pool_name


pool_set_disk_status_to_cache_start


ST8000AS0022-1WL17Z chenbiao
ST8000AS0002-1NA17Z malixing

for msn in `bcli disk list|grep -v "#" |awk '{print $NF}'`;do echo $msn;bcli db set /mod/disk/burntest/$msn/checkresult NORMAL;done


单机单控
bcli meta check_latest_metadata 1 0 1 0 0


dcli container manage --cname=b_cvr_record_0 --operation=delete --searchid=hello 
这个是删除
dcli container manage --cname=b_cvr_record_0 --operation=pause --searchid=hello 
这个暂停

/root/iraid/TOOLS/burntest_all_w_zk.sh

unsigned int         %u
unsigned long        %lu   strlen  sizeof(int)
long                 %ld   %lx
long long int        %lld
unsigned long long   %llu


/root/iraid/bin/iraid_sup docker -c check-env


我已经在跑用例了，你后续直接远程10.192.59.158可以看结果，用户名：administrator，密码：123




1、双控，首先在双控两端分别创建一个ramdisk，然后在一端创建pv，vg，lv；然后将激活lv一端关机，尝试再另一端激活vg和lv，看是否可以正常激活，是否可以扫到vg信息，是否可以利用其中一个pv上的信息进行激活vg 

2、vg的独立启停，设备创建多个vg，然后尝试以vg为单位进行激活停止，查看是否有相关命令或者方式，期望是不依赖配置文件  

pool_meta_start_rsync

pool_meta_start_rsync_backup


/mod/iraid/2/uuid=268d446a:70362a6a:b8a39574:75607dc5

/mod/pool/pools/%s/warn/%s/mod_node_id



页面创建iraid，显示容量为0
预分接口获取容量，传入参数pool_alias异常，传入参数pool_uuid正常


/root/iraid/bin/iraid_sup ui --iraid_list=create_cvr


https://10.100.44.2/storage-IPDPrj/2019/PJ01PD20190713012_磐石324/04研发/01系统工程/02系统方案/磐石32x录像模式性能表.xlsm 
 
modify_backup_disk_info
pool_meta_start_rsync
pool_meta_start_rsync_remote



pool_cget_iraid_disk_super_info

写结构体的位置：

pool_iraid_metadata_write_super

pool_write_super_by_zone_index  ->  pool_iraid_metadata_write_super


meta_slave_write_backup  ->  pool_iraid_metadata_write_super

pool_write_super_by_zone_index_by_remote  ->  meta_slave_write_backup  ->  pool_write_super_by_zone_index

meta_slave_erase_superblock  ->  pool_iraid_metadata_write_super

erase_superblock_by_iraid  ->  pool_iraid_metadata_write_super



/root/iraid/TOOLS/delete_all_local_iraid_meta_file.sh: stop iraid:rm -rf /etc/iraid/driver/iraid/3

/root/iraid/bin/iraid_sup docker -g all-uuid -i 1
cli_storage -a set -C POOL_STOP_BY_UUID -i pooluuid


#停止
casadm -T -i 1
modprobe -r brd
#启动
modprobe brd rd_nr=1 rd_size=1048576 max_part=0
casadm -S -i 1 -d /dev/ram0 -c wb
casadm -A -i 1 -d /dev/mapper/pool1-vdo0  


lvs: relocation error: lvs: symbol dm_tree_node_size_changed, version DM_1_02_107 not defined in file libdevmapper.so.1.02 with link time reference


dmsetup create pool --table "0 20971520 thin-pool /dev/sdb /dev/sdc 256000 90"

drop_caches
/tmp/BnCron.conf  
当前的BnCron的执行的命令的文件
 /b_iscsi/bin/MakeDaemonConfig.pl 
这个是BnCron的配置文件


/bin/echo unmaintain > /sys/block/md%d/md/iraid/unmaintain_seg 

/mod/iraid/262/capacity=569083166720

[root@localhost home]# ll /dev/hik-bcache259 
lrwxrwxrwx 1 root root 12 Jun 18 21:57 /dev/hik-bcache259 -> /dev/bcache0

[root@localhost home]# bcli db tree /mod/iraid/259/capacity
/mod/iraid/259/capacity=1124207689728

1693290856448



bcli pool disklist -p test1 |awk '$5=="OK:OK->OK"{print $2,$8;i++;if(i==3)exit}'



_get_local_iraid_list 
pool_get_degmraid_for_reconsitution
替换为
/root/iraid/bin/iraid_sup docker -g iraid_id

pool_name=$1


#每块盘目前未使用的段记录为空闲列表
for disk in `bcli pool disklist -p $pool_name|grep -v "#" |awk '{print $1}'`
do
    bcli meta show $disk |grep -v "#" |awk '$6=="1"{print $1}' > /home/unused_seg.$disk.log
done


#diskable的mraid中已经使用的磁盘
bcli iraid metainfo 257 |grep ^Mraid |tail -1|awk '{for(i=5;i<=NF;i++) print $i}' |sed s'/-\|:/ /'g|awk '{print $2}' > /home/use_disk


for disk in `bcli pool disklist -p $pool_name|grep -v "#" |awk '{print $1}'`
do 
    cat /home/use_disk |grep $disk > /dev/null
    if [ $? -ne 0 ]; then
        #输出mraid中未使用的磁盘
        #echo $disk
        #未使用的盘中找第一个未使用的段
        unused_seg=`cat /home/unused_seg.$disk.log |head -1
        #此段用后从删除
        sed -i "/$unused_seg/d" /home/unused_seg.$disk.log

        echo "mraid$index" > /home/mraid$index.log
        echo "$disk-$unused_seg" >> /home/mraid$index.log
    fi
done

#一列变一行
awk '{printf "%s,", $1}' /home/mraid.log


for log in `ls unused_seg.*.log`
do
    id=`echo $log |sed 's/[^0-9]//g'`
    cat $log | while read seg
    do
        echo "$id-$seg" >> $id.log
    done
done

unused_seg=`grep "$diskid-" pool.log |head -1`






bcli iraid create -p test iraid-1 1024G 4k 7 8+8:0 -t thick -w 1 -g 1 -v 0 -r 1  


想把本地的/etc/iraid/driver/remote/2目录同步到10.192.53.111的/etc/iraid/driver/remote/2目录
"/usr/bin/rsync -arc  /etc/iraid/driver/remote/2 --timeout=5 --inplace --contimeout=5 HikBn@10.192.53.111::iraid --password-file=/etc/rsync.password"

/usr/bin/rsync -arc /etc/iraid/driver/remote/2/ root@10.192.53.111:/etc/iraid/driver/remote/2





想把远端10.192.53.111的/etc/iraid/driver/local/2/目录同步到本地的/etc/iraid/driver/local/2目录
"/usr/bin/rsync -arc --timeout=5 --inplace  root@10.192.53.111:/etc/iraid/driver/local/2/ /etc/iraid/driver/local/2"

/usr/bin/rsync -arc root@10.192.53.111:/etc/iraid/driver/local/2/ /etc/iraid/driver/local/2


激活
btier_setup -f /dev/md1 -c     
停止  
btier_setup -d /dev/sdtiera      
/home/wujl/btier-1.X-master 
 

mdadm -CR -v /dev/md1 -l 1 -n $i $devicelist --assume-clean --force

bcli node showallnode
bcli node add_domain -i 域IP -m 255.255.255.0 -n 1
然后bcli evd start
bcli node start
bcli zoo start
/home/hikos/system/bin/dsk_domain_svr -D 
cli_dsk_domain -a set -c DSK_DOMAIN_INITIALIZE -I 1 


lvm损坏修复
pvcreate --yes -ff --metadatasize 1m --uuid 8MsSQJ-Znc0-HE4n-OS9Q-iNle-yoBD-Se12UU --restorefile /etc/lvm/backup/pool_tier_1 /dev/sdtiera
vgcfgrestore -f /etc/lvm/backup/pool_tier_1 pool_tier_1



human_size() 
{
    awk -v sum="$1" ' BEGIN {hum[1024^3]="Gb"; hum[1024^2]="Mb"; hum[1024]="Kb"; for (x=1024^3; x>=1024; x/=1024) { if (sum>=x) { printf "%.2f %s\n",sum/x,hum[x]; break; } } if (sum<1024) print "1kb"; } '
}


hikos_log(STORAGE_ACTION_SET, LOG_SET_OPERATION_LOG,"0x01060020", NULL,"%s,%s",name,dev);
FusionOS_V2.0.0_XC_DOUBLE\system\config\rules_oplog_chinese.csv




2020-11-02 22:36:52 [[level:WARN] libhikos_softraid.c->softraid_set_io_mode:5422] Error iotype


bcli dm /root/iraid/SCRIPTS/san_module.sh stop
bcli dm con "/root/iraid/SCRIPTS/san_module.sh after_domain_create"


cd /dom/storoswd/docker/log/containers/b_cvr_record_0/ 
310_ctrl_stor_info.log



cat 2.metainfo |grep Mraid39603|wc -l

for((id=0;id<=53737;id++))
do 
    num=`cat 2.metainfo |grep Mraid$id|wc -l`
    if [[ $num -eq 2 ]];then 
        echo $id 
    fi 
done


extc_unplug_delay_lock_work:4950:***ERROR***: ===delay_unlock===RSYNC-UNLOCK==


iostat -x 1 |grep -E "Device|sd[^d-z]|dm-[^0-2]"



echo "262144 - 282624" >  /sys/block/sdx/device/device_recorded_section

# --writemostly参数设置y值后raid1底层的分支/dev/ram15只写不读,设置n值后关闭
lvchange --writemostly /dev/ram15:y /dev/vg/lv1
# 可查看
lvs -a -o lv_name,vg_name,attr,size,devices vg_name


modprobe brd rd_nr=4 rd_size=1048576 max_part=0
losetup -f /dev/ram0
losetup -f /dev/ram1

fio -filename=/dev/md1 -direct=1 -rw=read -bs=1M -numjobs=512 -group_reporting -name=test-read
E:\0mySVN\BRANCHES\920StorOS_V2.0.0\BIOS\smi\bin

backup_all_metadata.shbackup_all_metadata.shbackup_all_metadata.sh

添加ramdisk接口 echo "brd_add  name size addr" >/proc/brd_hik/brd_set  查看接口：cat /proc/brd_hik/brd_set


fio -group_reporting -name="test" -ioengine=libaio -iodepth=1 -direct=1 -bs=1M -rw=write -size=1t -runtime=120 -filename=/dev/vgtest/lvol1  

fio -name=test -filename=/mnt/wangzhe/test1 -direct=0 -thread -rw=randread -ioengine=psync -bs=4k -size=3T -runtime=120


lvcreate --errorwhenfull y -L 10g --thinpool $thinpool_name $vg_name 

lvcreate -n kvm_pool -L 2t sp /dev/md1
lvcreate -n meta -L 1g sp /dev/sdi

lvconvert --type thin-pool --poolmetadata sp/meta sp/kvm_pool

lvcreate -V 119G -n lvol1 --thin sp/kvm_pool


lvcreate -n ThinDataLV -L LargeSize VG
lvcreate -n ThinMetaLV -L SmallSize VG
lvconvert --type thin-pool --poolmetadata VG/ThinMetaLV VG/ThinDataLV
lvcreate -n ThinLV -V VirtualSize --thinpool ThinPoolLV VG

lvconvert --repair VG/ThinPoolLV


lvcreate -L 2048G --thinpool thin_pool sp
lvcreate -V 100G -n lvol1 --thin sp/thin_pool

 --stripesize


vgreduce -ff --removemissing sp

Apr 12 14:11:13 localhost share_disk[15450]: the environment_domain is iraid_domain, donot insmod raid1 driver, but return 0
Apr 12 14:11:13 localhost load_raid_modules.sh[15403]: share_disk: the environment_domain is iraid_domain, donot insmod raid1 driver, but return 0
Apr 12 14:11:13 localhost systemd[1]: Started iRAID load_raid1_driver service.

[root@HikvisionOS wangzhe]# md5sum /home/2G_test 
84b78867807b9e056b5f8e1833fc8bfa  /home/2G_test

[root@HikvisionOS wangzhe]# md5sum /home/1G_test 
cd3f2223a23a8cb0eff138367c170f04  /home/1G_test


[root@HikvisionOS ~]# pvs
  WARNING: Device for PV HB5EwB-KB88-mVgs-VUnR-832F-sLff-Ky4uhv not found or rejected by a filter.
  Couldn't find device with uuid HB5EwB-KB88-mVgs-VUnR-832F-sLff-Ky4uhv.
  WARNING: Couldn't find all devices for LV vg_cache_a/lv_cache_a_rimage_0 while checking used and assumed devices.
  WARNING: Couldn't find all devices for LV vg_cache_a/lv_cache_a_rmeta_0 while checking used and assumed devices.
  WARNING: Device for PV XjqOVd-cXxC-MA6e-gm4A-FkSk-IGLx-JaheU4 not found or rejected by a filter.
  Couldn't find device with uuid XjqOVd-cXxC-MA6e-gm4A-FkSk-IGLx-JaheU4.
  WARNING: Couldn't find all devices for LV vg_cache_b/lv_cache_b_rimage_1 while checking used and assumed devices.
  WARNING: Couldn't find all devices for LV vg_cache_b/lv_cache_b_rmeta_1 while checking used and assumed devices.
  PV           VG          Fmt  Attr PSize   PFree  
  /dev/hbrd_b0 vg_cache_b  lvm2 a--   <8.00g      0 
  /dev/hbrd_b1 vg_cache_a  lvm2 a--   <8.00g      0 
  /dev/hda3    HIKOS       lvm2 a--  <29.06g      0 
  /dev/hda5    HIKOS       lvm2 a--  <61.00g   3.55g
  /dev/hda6    HIKMETADATA lvm2 a--  <10.00g 252.00m
  /dev/hda7    HIKLOG      lvm2 a--  <10.00g 252.00m
  /dev/hda8    HIKEXTEND   lvm2 a--  109.50g   1.50g
  [unknown]    vg_cache_a  lvm2 a-m   <8.00g      0 
  [unknown]    vg_cache_b  lvm2 a-m   <8.00g      0

  [root@HikvisionOS ~]# lvs -a -o+devices
  WARNING: Device for PV HB5EwB-KB88-mVgs-VUnR-832F-sLff-Ky4uhv not found or rejected by a filter.
  Couldn't find device with uuid HB5EwB-KB88-mVgs-VUnR-832F-sLff-Ky4uhv.
  WARNING: Couldn't find all devices for LV vg_cache_a/lv_cache_a_rimage_0 while checking used and assumed devices.
  WARNING: Couldn't find all devices for LV vg_cache_a/lv_cache_a_rmeta_0 while checking used and assumed devices.
  WARNING: Device for PV XjqOVd-cXxC-MA6e-gm4A-FkSk-IGLx-JaheU4 not found or rejected by a filter.
  Couldn't find device with uuid XjqOVd-cXxC-MA6e-gm4A-FkSk-IGLx-JaheU4.
  WARNING: Couldn't find all devices for LV vg_cache_b/lv_cache_b_rimage_1 while checking used and assumed devices.
  WARNING: Couldn't find all devices for LV vg_cache_b/lv_cache_b_rmeta_1 while checking used and assumed devices.
  LV                    VG          Attr       LSize   Pool          Origin Data%  Meta%  Move Log Cpy%Sync Convert Devices                                                                                                                          
  lv_cache_a            vg_cache_a  rwi---r-p-   7.99g                                                              lv_cache_a_rimage_0(0),lv_cache_a_rimage_1(0)
  [lv_cache_a_rimage_0] vg_cache_a  Iwi-a-r-p-   7.99g                                                              [unknown](1)                                 
  [lv_cache_a_rimage_1] vg_cache_a  Iwi-a-r-r-   7.99g                                                              /dev/hbrd_b1(1)                              
  [lv_cache_a_rmeta_0]  vg_cache_a  ewi-a-r-p-   4.00m                                                              [unknown](0)                                 
  [lv_cache_a_rmeta_1]  vg_cache_a  ewi-a-r-r-   4.00m                                                              /dev/hbrd_b1(0)                              
  lv_cache_b            vg_cache_b  rwi-aor-p-   7.99g                                             100.00           lv_cache_b_rimage_0(0),lv_cache_b_rimage_1(0)
  [lv_cache_b_rimage_0] vg_cache_b  iwi-aor---   7.99g                                                              /dev/hbrd_b0(1)                              
  [lv_cache_b_rimage_1] vg_cache_b  iwi-aor-p-   7.99g                                                              [unknown](1)                                 
  [lv_cache_b_rmeta_0]  vg_cache_b  ewi-aor---   4.00m                                                              /dev/hbrd_b0(0)                              
  [lv_cache_b_rmeta_1]  vg_cache_b  ewi-aor-p-   4.00m                                                              [unknown](0)                                 
[root@HikvisionOS ~]# 

[root@HikvisionOS ~]# lvchange -ay /dev/vg_cache_a/lv_cache_a 
  WARNING: Device for PV HB5EwB-KB88-mVgs-VUnR-832F-sLff-Ky4uhv not found or rejected by a filter.
  Couldn't find device with uuid HB5EwB-KB88-mVgs-VUnR-832F-sLff-Ky4uhv.
  WARNING: Couldn't find all devices for LV vg_cache_a/lv_cache_a_rimage_0 while checking used and assumed devices.
  WARNING: Couldn't find all devices for LV vg_cache_a/lv_cache_a_rmeta_0 while checking used and assumed devices.
  Activation of logical volume vg_cache_a/lv_cache_a is prohibited while logical volume vg_cache_a/lv_cache_a_rimage_0 is active.
[root@HikvisionOS ~]# 

vgreduce -ff --removemissing vg_cache_a

[root@HikvisionOS ~]# lvs -a -o+devices
  Internal error: WARNING: Segment type linear found does not match expected type error for vg_cache_a/lv_cache_a_rimage_0.
  Internal error: WARNING: Segment type linear found does not match expected type error for vg_cache_a/lv_cache_a_rmeta_0.
  WARNING: Device for PV XjqOVd-cXxC-MA6e-gm4A-FkSk-IGLx-JaheU4 not found or rejected by a filter.
  Couldn't find device with uuid XjqOVd-cXxC-MA6e-gm4A-FkSk-IGLx-JaheU4.
  WARNING: Couldn't find all devices for LV vg_cache_b/lv_cache_b_rimage_1 while checking used and assumed devices.
  WARNING: Couldn't find all devices for LV vg_cache_b/lv_cache_b_rmeta_1 while checking used and assumed devices.
  LV                    VG          Attr       LSize   Pool          Origin Data%  Meta%  Move Log Cpy%Sync Convert Devices                                                                                                                     
  lv_cache_a            vg_cache_a  rwi---r---   7.99g                                                              lv_cache_a_rimage_0(0),lv_cache_a_rimage_1(0)
  [lv_cache_a_rimage_0] vg_cache_a  vwi-XXr-r-   7.99g                                                                                                           
  [lv_cache_a_rimage_1] vg_cache_a  Iwi-a-r-r-   7.99g                                                              /dev/hbrd_b1(1)                              
  [lv_cache_a_rmeta_0]  vg_cache_a  ewi-XXr-r-   4.00m                                                                                                           
  [lv_cache_a_rmeta_1]  vg_cache_a  ewi-a-r-r-   4.00m                                                              /dev/hbrd_b1(0)                              
  lv_cache_b            vg_cache_b  rwi-aor-p-   7.99g                                             100.00           lv_cache_b_rimage_0(0),lv_cache_b_rimage_1(0)
  [lv_cache_b_rimage_0] vg_cache_b  iwi-aor---   7.99g                                                              /dev/hbrd_b0(1)                              
  [lv_cache_b_rimage_1] vg_cache_b  iwi-aor-p-   7.99g                                                              [unknown](1)                                 
  [lv_cache_b_rmeta_0]  vg_cache_b  ewi-aor---   4.00m                                                              /dev/hbrd_b0(0)                              
  [lv_cache_b_rmeta_1]  vg_cache_b  ewi-aor-p-   4.00m                                                              [unknown](0)                                 
[root@HikvisionOS ~]# 


[root@HikvisionOS wangzhe]# md5sum /home/5G_test 
b445ef125f302c9f9dbcd93991aad653  /home/5G_test

[root@HikvisionOS ~]# md5sum /home/2G_test 
84b78867807b9e056b5f8e1833fc8bfa  /home/2G_test

[root@HikvisionOS ~]# md5sum /home/1G_test 
cd3f2223a23a8cb0eff138367c170f04  /home/1G_test


11写本地a0：
dd if=/home/1G_test of=/dev/hbrd_a0 bs=1M oflag=direct
12读远端a0：
dd if=/dev/hbrd_a0 of=a0_1.log bs=1M count=1024 iflag=direct
[root@HikvisionOS ~]# md5sum  a0_1.log 
cd3f2223a23a8cb0eff138367c170f04 a0_1.log
一致

11写远端b1：
dd if=/home/2G_test of=/dev/hbrd_b1 bs=1M oflag=direct
12读本地b1：
dd if=/dev/hbrd_b1 of=b1_1.log bs=1M count=2048 iflag=direct
[root@HikvisionOS ~]# md5sum b1_1.log 
84b78867807b9e056b5f8e1833fc8bfa  b1_1.log
一致


融合OS2.1的测试的lvm的问题我有点不明白了，问题原因是/etc/lvm/lvm.conf文件里多了一个参数allow_mixed_block_sizes = 1导致命令报警告

我看了一下纯软部署的lvm升级包，这个版本是对的，lvm2-2.02.185-2.el7_7.2.x86_64.rpm
路径是：Z:\存储业务部\Ceph组\外部文件\融合OS\组件纯软部署\FusionOS\FusionOS-OS\rpm\hikos_sys\lvm2-2.02.185-2.el7_7.2.x86_64.rpm

我打开这个rpm包看到里面的配置文件是对的，如截图右边，
但是我新刻卡的设备56.148上/etc/lvm/lvm.conf如截图左侧，多了这样一个选项后会报警告。
现在感觉像是是纯软部署打了这个rpm包以后，lvm.conf被修改多加了这样一项，但是56.148我早上刚刻卡，没打别的包。

storos-202104100403-B_OS-StorOS_V2.0.0-920-SIGN.bin
2021-04-10 13:47:46    10.192.55.158    0x0100007a    正常    升级包上传成功(升级包名称:storos-202104100403-B_OS-StorOS_V2.0.0-920-SIGN.bin)



默认情况下，lvcreate 根据方程式（Pool_LV_size / Pool_LV_chunk_size * 64）设定精简池元数据逻辑卷的大小

设定thinpool报警阈值      cli_storage -a set -c LVM_SET_THRESHOLD -i "threshold:%d" -? 'NODES all'
获取thinpool报警阈值      cli_storage -a get -c LVM_GET_THRESHOLD -i "thinpool_type:all"


A:
[root@HikvisionOS wangzhe]# cat /sys/ntb/ntb_info/*
a0_phy_addr  0x400100000
0x1fff00000
a1_phy_addr  0x600100000
0x1fff00000
b0_phy_addr  0x3c000100000
0x1fff00000
b1_phy_addr  0x3c200100000
0x1fff00000
1

B:
[root@HikvisionOS wangzhe]# cat /sys/ntb/ntb_info/*
a0_phy_addr  0x3c000100000
0x1fff00000
a1_phy_addr  0x3c200100000
0x1fff00000
b0_phy_addr  0x400100000
0x1fff00000
b1_phy_addr  0x600100000
0x1fff00000
1

sed 's/-0\|[0-9]-\|::[0-9]*\[[a-zA-Z]\{1,\}]\|k\:0]: \|\[ \|normal\|degrade\|disable\|recover//g'|sed 's/:/-/g'|sed s'/ \{1,\}/ /g'|sed s'/ /,/g'|sed 's/Mraid/mraid/g'

sed 's/-0\|[0-9]-\|::[0-9]*\[[a-zA-Z]\{1,\}]\|k\:0]: \|\[ \|normal\|degrade\|disable\|recover//g'|sed 's/:/-/g'|tr -s " "|sed 's/[ \t]*$//g' |sed s'/ /,/g'

sed 's/-0\|[0-9]-\|::[0-9]*\[[a-zA-Z]\{1,\}]\|k\:0]: \|\[ \|normal\|degrade\|disable\|recover\|[ \t]*$//g'|sed 's/:/-/g'|tr -s " "|sed s'/ /,/g'|sed 's/M/m/g'

perf bench mem all

dd  (15451)
"md1"  17
 0xffffffff81290820 : generic_make_request+0x0/0x130 [kernel]
 0xffffffffa037aa1f : __clone_and_map_data_bio+0x14f/0x230 [dm_mod]
 0xffffffffa037ae77 : __split_and_process_bio+0x377/0x4f0 [dm_mod]
 0xffffffffa037b0ec : dm_request+0xfc/0x1a0 [dm_mod]
 0xffffffff81290902 : generic_make_request+0xe2/0x130 [kernel]
 0xffffffff812909c1 : submit_bio+0x71/0x150 [kernel]
 0xffffffff811ee363 : do_blockdev_direct_IO+0x2203/0x2620 [kernel]
 0xffffffff811ee7d5 : __blockdev_direct_IO+0x55/0x60 [kernel]
 0xffffffff811e8f67 : blkdev_direct_IO+0x57/0x60 [kernel]
 0xffffffff811e8910 : blkdev_get_block+0x0/0x20 [kernel]
 0xffffffff811434ed : generic_file_direct_write+0xcd/0x190 [kernel] (inexact)
 0xffffffff811438cc : __generic_file_aio_write+0x31c/0x3e0 [kernel] (inexact)
 0xffffffff811e98ea : blkdev_aio_write+0x5a/0xd0 [kernel] (inexact)
 0xffffffff811af39d : do_sync_write+0x8d/0xd0 [kernel] (inexact)
 0xffffffff811afb3d : vfs_write+0xbd/0x1e0 [kernel] (inexact)
 0xffffffff811b0588 : sys_write+0x58/0xb0 [kernel] (inexact)
 0xffffffff815c5019 : system_call_fastpath+0x16/0x1b [kernel] (inexact)


thin :
kworker/u16:0  (27356)
"md1"  0
 0xffffffff81290820 : generic_make_request+0x0/0x130 [kernel]
 0xffffffffa037aa1f : __clone_and_map_data_bio+0x14f/0x230 [dm_mod]
 0xffffffffa037ae77 : __split_and_process_bio+0x377/0x4f0 [dm_mod]
 0xffffffffa037b0ec : dm_request+0xfc/0x1a0 [dm_mod]
 0xffffffff81290902 : generic_make_request+0xe2/0x130 [kernel]
 0xffffffff812909c1 : submit_bio+0x71/0x150 [kernel]
 0xffffffffa0425583 : submit_io+0x1d3/0x1f0 [dm_bufio]
 0xffffffffa0426f15 : new_read+0xe5/0x110 [dm_bufio]
 0xffffffffa0426f89 : dm_bufio_read+0x29/0x30 [dm_bufio]
 0xffffffffa0fdd6d2 : dm_bm_read_lock+0x42/0x1d0 [dm_persistent_data]
 0xffffffffa0fe0e58 : dm_tm_read_lock+0x18/0x30 [dm_persistent_data]
 0xffffffffa0fe36d6 : ro_step+0x36/0x70 [dm_persistent_data]
 0xffffffffa0fe2301 : dm_btree_lookup+0xb1/0x1f0 [dm_persistent_data]
 0xffffffffa0fde0c8 : disk_ll_load_ie+0x28/0x30 [dm_persistent_data]
 0xffffffffa0fdece0 : sm_ll_find_free_block+0x80/0x1c0 [dm_persistent_data]
 0xffffffffa0fdf854 : sm_disk_new_block+0x44/0xc0 [dm_persistent_data]
 0xffffffffa0ffb121 : dm_pool_alloc_data_block+0x41/0x60 [dm_thin_pool]
 0xffffffffa0ff61ef : alloc_data_block.isra.29+0x6f/0x1a0 [dm_thin_pool]
 0xffffffffa0ff873d : process_bio+0x38d/0x5e0 [dm_thin_pool]
 0xffffffffa0ff782c : do_worker+0x19c/0x310 [dm_thin_pool]

kworker/u16:0  (27356)
"md1"  0
 0xffffffff81290820 : generic_make_request+0x0/0x130 [kernel]
 0xffffffffa037aa1f : __clone_and_map_data_bio+0x14f/0x230 [dm_mod]
 0xffffffffa037ae77 : __split_and_process_bio+0x377/0x4f0 [dm_mod]
 0xffffffffa037b0ec : dm_request+0xfc/0x1a0 [dm_mod]
 0xffffffff81290902 : generic_make_request+0xe2/0x130 [kernel]
 0xffffffff812909c1 : submit_bio+0x71/0x150 [kernel]
 0xffffffffa0425583 : submit_io+0x1d3/0x1f0 [dm_bufio]
 0xffffffffa0426f15 : new_read+0xe5/0x110 [dm_bufio]
 0xffffffffa0426f89 : dm_bufio_read+0x29/0x30 [dm_bufio]
 0xffffffffa0fdd6d2 : dm_bm_read_lock+0x42/0x1d0 [dm_persistent_data]
 0xffffffffa0fe0e58 : dm_tm_read_lock+0x18/0x30 [dm_persistent_data]
 0xffffffffa0fded67 : sm_ll_find_free_block+0x107/0x1c0 [dm_persistent_data]
 0xffffffffa0fdf854 : sm_disk_new_block+0x44/0xc0 [dm_persistent_data]
 0xffffffffa0ffb121 : dm_pool_alloc_data_block+0x41/0x60 [dm_thin_pool]
 0xffffffffa0ff61ef : alloc_data_block.isra.29+0x6f/0x1a0 [dm_thin_pool]
 0xffffffffa0ff873d : process_bio+0x38d/0x5e0 [dm_thin_pool]
 0xffffffffa0ff782c : do_worker+0x19c/0x310 [dm_thin_pool]
 0xffffffff8107e02b : process_one_work+0x17b/0x460 [kernel]
 0xffffffff8107edfb : worker_thread+0x11b/0x400 [kernel]
 0xffffffff81085aef : kthread+0xcf/0xe0 [kernel]

kworker/u16:0  (27356)
"md1"  1
 0xffffffff81290820 : generic_make_request+0x0/0x130 [kernel]
 0xffffffffa037aa1f : __clone_and_map_data_bio+0x14f/0x230 [dm_mod]
 0xffffffffa037ae77 : __split_and_process_bio+0x377/0x4f0 [dm_mod]
 0xffffffffa037b0ec : dm_request+0xfc/0x1a0 [dm_mod]
 0xffffffff81290902 : generic_make_request+0xe2/0x130 [kernel]
 0xffffffff812909c1 : submit_bio+0x71/0x150 [kernel]
 0xffffffffa0425583 : submit_io+0x1d3/0x1f0 [dm_bufio]
 0xffffffffa0425604 : __flush_write_list+0x64/0xb0 [dm_bufio]
 0xffffffffa0427209 : dm_bufio_write_dirty_buffers+0x59/0x0 [dm_bufio]
 0xffffffffa0fdd2ec : dm_bm_flush+0x1c/0x20 [dm_persistent_data]
 0xffffffffa0fe0c6f : dm_tm_pre_commit+0x2f/0x40 [dm_persistent_data]
 0xffffffffa0ff9c47 : __commit_transaction+0x107/0x3a0 [dm_thin_pool]
 0xffffffffa0ffb177 : dm_pool_commit_metadata+0x37/0x60 [dm_thin_pool]
 0xffffffffa0ff5664 : commit+0x24/0x60 [dm_thin_pool]
 0xffffffffa0ff7975 : do_worker+0x2e5/0x310 [dm_thin_pool]
 0xffffffff8107e02b : process_one_work+0x17b/0x460 [kernel]
 0xffffffff8107edfb : worker_thread+0x11b/0x400 [kernel]
 0xffffffff81085aef : kthread+0xcf/0xe0 [kernel]
 0xffffffff815c4f6c : ret_from_fork+0x7c/0xb0 [kernel]
 0xffffffff81085a20 : kthread+0x0/0xe0 [kernel] (inexact)

kworker/u16:0  (27356)
"md1"  5137
 0xffffffff81290820 : generic_make_request+0x0/0x130 [kernel]
 0xffffffffa037a8c3 : __clone_and_map_simple_bio+0x83/0x90 [dm_mod]
 0xffffffffa037af3b : __split_and_process_bio+0x43b/0x4f0 [dm_mod]
 0xffffffffa037b0ec : dm_request+0xfc/0x1a0 [dm_mod]
 0xffffffff81290902 : generic_make_request+0xe2/0x130 [kernel]
 0xffffffff812909c1 : submit_bio+0x71/0x150 [kernel]
 0xffffffffa038352e : dispatch_io+0x18e/0x360 [dm_mod]
 0xffffffffa0383787 : sync_io+0x87/0x170 [dm_mod]
 0xffffffffa0383a55 : dm_io+0x1e5/0x220 [dm_mod]
 0xffffffffa04260f5 : dm_bufio_issue_flush+0x85/0xb0 [dm_bufio]
 0xffffffffa0427391 : dm_bufio_write_dirty_buffers+0x1e1/0x0 [dm_bufio]
 0xffffffffa0fdd2ec : dm_bm_flush+0x1c/0x20 [dm_persistent_data]
 0xffffffffa0fe0c6f : dm_tm_pre_commit+0x2f/0x40 [dm_persistent_data]
 0xffffffffa0ff9c47 : __commit_transaction+0x107/0x3a0 [dm_thin_pool]
 0xffffffffa0ffb177 : dm_pool_commit_metadata+0x37/0x60 [dm_thin_pool]
 0xffffffffa0ff5664 : commit+0x24/0x60 [dm_thin_pool]
 0xffffffffa0ff7975 : do_worker+0x2e5/0x310 [dm_thin_pool]
 0xffffffff8107e02b : process_one_work+0x17b/0x460 [kernel]
 0xffffffff8107edfb : worker_thread+0x11b/0x400 [kernel]
 0xffffffff81085aef : kthread+0xcf/0xe0 [kernel]










#创建物理卷
pvcreate /dev/md2 
#创建卷组
vgcreate sp /dev/md2 
#创建精简池
lvcreate -l 100%free --thinpool kvm_pool sp -Zn
#创建精简卷
lvcreate -V 120G -n lv1 --thin sp/kvm_pool

[root@HikvisionOS ~]# cat /sys/ntb/ntb_info/*
0x1fff00000
0xffffaced80000000
0x1fff00000
0xffffacef7ff00000
0x1fff00000
0xffffacf1c0100000
0x1fff00000
0xffffacf3c0000000
1

# 镜像管理器的配置文件（manager.conf）
以2022/10/25的`manager.conf`内容为例: \
debug = true #输出调试日志
```
[server]
addr = "127.0.0.1" #本机localhost
port = 12345 #manager-worker通讯接口
ssl_cert = "" #加密通讯
ssl_key = "" #加密通讯
#考虑到镜像站当前架构下前后端在同一实例，无须配置加密通讯

[files]
db_type = "bolt"#数据库类型
db_file = "/home/qlu_mirrors/manager.db"#数据库位置
ca_cert = ""#加密
```
# 镜像同步器的配置文件（worker.conf）
以2022/10/25的`worker.conf`内容为例： \
```
[global] #全局设置
name = "QLU_Mirrors" #同步器名称
log_dir = "/home/qlu_mirrors/{{.Name}}" #日志文件位置
mirror_dir = "/mnt/vos-6izqwyw8/mirrors" #镜像文件位置
concurrent = 4 #同步并发数
interval = 720 #同步周期

[manager]
api_base = "http://localhost:12345" #端口号为manager-worker通讯接口
token = "" #考虑到前后端一体
ca_cert = "" #不做加密处理


[server]
hostname = "localhost" #本机
listen_addr = "127.0.0.1" #本机
listen_port = 6000 #worker监听
ssl_cert = "" #考虑到前后端一体
ssl_key = "" #不做加密处理

[[mirrors]]
name = "ros" #镜像名称
provider = "rsync" #同步方式
upstream = "rsync://mirror.umd.edu/packages.ros.org/ros/" #上游地址
use_ipv6 = false #不使用ipv6

[[mirrors]]
name = "centos"
provider = "rsync"
upstream = "rsync://rsync.mirrors.ustc.edu.cn/centos/"
use_ipv6 = false
[[mirrors]]
name = "kali"
provider = "rsync"
upstream = "rsync://rsync.mirrors.ustc.edu.cn/kali/"
use_ipv6 = false
interval = 720 #可单独设置同步周期
[[mirrors]]
name = "ubuntu"
provider = "rsync"
upstream = "rsync://rsync.mirrors.ustc.edu.cn/ubuntu/"
use_ipv6 = false
[[mirrors]]
name = "archlinux"
provider = "rsync"
upstream = "rsync://rsync.mirrors.ustc.edu.cn/archlinux/"
use_ipv6 = false
```
# 启动镜像管理器
`./sync manager --config /path/of/manager.conf`
# 启动镜像同步器
`./sync worker --config /path/of/worker.conf`
# 注意事项
如果你不想断开ssh后挂掉镜像控制器，请务必使用`screen` \
`screen [-AmRvx -ls -wipe][-d <作业名称>][-h <行数>][-r <作业名称>][-s <shell>][-S <作业名称>]`
```
-A 　将所有的视窗都调整为目前终端机的大小。
-d<作业名称> 　将指定的screen作业离线。
-h<行数> 　指定视窗的缓冲区行数。
-m 　即使目前已在作业中的screen作业，仍强制建立新的screen作业。
-r<作业名称> 　恢复离线的screen作业。
-R 　先试图恢复离线的作业。若找不到离线的作业，即建立新的screen作业。
-s<shell> 　指定建立新视窗时，所要执行的shell。
-S<作业名称> 　指定screen作业的名称。
-v 　显示版本信息。
-x 　恢复之前离线的screen作业。
-ls或--list 　显示目前所有的screen作业。
-wipe 　检查目前所有的screen作业，并删除已经无法使用的screen作业。
```

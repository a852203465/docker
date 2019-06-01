1. 下载镜像

docker pull 

2. 哨兵的配置文件 （集群启动后会自动更新该配置文件 ）解释

1）  monitor     指的是初始化的监控主切点，ip和端口，后面的数字2代表，必须2个sentinel才能判断主节点是否失败

2）down-after-milliseconds   指的是超过5000秒，且没有回复，则判定主节点不可达

3）failover-timeout    指的是故障转移时间

4）parallel-syncs   指的是故障转移到新的主节点时，从节点的复制节点数量

3. 启动redis 集群

docker-compose up -d

4. 问题解决

1）Sentinel config file /etc/redis/sentinel.conf is not writable: Permission denied. Exiting...
问题描述：映射文件权限不足
解决方式： 修改宿主机映射文件权限

sudo chmod -R 777  data     # data: 映射文件根目录

4. 验证集群

1）连接基本一个sentinel

docker exec -it sentinel-1 redis-cli -h sentinel-1 -p 26379

2）查看基本信息

info

3）查看master

sentinel masters

4 ）查看slaves

sentinel slaves mymaster

可能会输出：(empty list or set)

5）连接master，并存入一个key和value

docker exec -it master redis-cli -h master -p 16379

set mrj_name boshenboshen

6)连接slave1，获取mrj_name的值

docker exec -it slave1 redis-cli -h slave1 -p 16380

get boshen_name ---> "boshenboshen"

set mrj_age 20 --> (error) READONLY You can't write against a read only slave.

可知 由报错可知，从节点，不能写数据








服务配置:

1. 构建镜像

执行build.sh 脚本，命令 sh build.sh

2. 启动ntp服务器

运行docker-compose.yml， 命令：docker-compose up -d

3. 查看服务状态

docker exec -it ntp-server service ntp status

客户端配置：

注：

当前运行容器不需要配置客户端，
 
客户端与服务端不能在同一台机器上运行，

 前的服务器是用主机的时间作为标准时间的
 
 
 1. 安装ntpdate
 
 sudo apt-get install ntpdate
 
 2. 同步主机时间
 
 sudo ntpdate 192.168.0.20  
 注： 这里的ip是ntp容器运行的主机
 
 3. 配置定时任务更新时间
 
 切换root, 执行crontab -l，查看某个用户cron服务的详细内容

4. 编辑定时任务

crontab -e，在文件末尾增加 * * * * * ntpdate 192.168.0.20

常见周期

每五分钟执行  */5 * * * *

每小时执行     0 * * * *

每天执行        0 0 * * *

每周执行       0 0 * * 0

每月执行        0 0 1 * *

每年执行       0 0 1 1 *

5. 重启定时任务服务

sudo service cron restart 

6. 查看日志

journalctl -n 10 -f -u cron














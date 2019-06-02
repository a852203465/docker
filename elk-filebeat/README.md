1. 运行 镜像文件

进入 elk-filebeat 文件夹, 执行命令

docker-compose up -d

2. 查看 容器状态

docker ps

3. 相关问题整理

3.1 max file descriptors [65535] for elasticsearch process is too low, increase to at least [65536]

编辑 /etc/security/limits.conf，追加以下内容；
* soft nofile 65536
* hard nofile 65536
此文件修改后需要重新登录用户，才会生效

3.2 max virtual memory areas vm.max_map_count [65530] is too low, increase to at least [262144]

编辑 /etc/sysctl.conf，追加以下内容：
vm.max_map_count=655360
保存后，执行：
sysctl -p

重新启动，成功。

注意：若遇上如上问题，编辑相关文件后，需重新运行镜像

3.3 Exiting: error loading config file: config file ("filebeat.yml") must be owned by the beat user (uid=0) or root

问题描述：报错处理，必须文件所属于root
问题解决：chown -R root filebeat.yml

3.4 Exiting: error loading config file: config file ("filebeat.yml") can only be writable by the owner but the permissions are "-rw-rw-r--" (to fix the permissions use: 'chmod go-w /filebeat.yml')

问题解决：chmod go-w filebeat.yml

4. filebeat 挂载说明

filebeat抓取日志进度数据，挂载到本地，防止filebeat容器重启，所有日志重新抓取
因为要收集docker容器的日志，所以要挂在到docker日志存储目录，使它有读取权限

5. 区分日志具体所属日志来源

在docker 容器上配置如下信息：

# 设置labels
    labels:
      service: db # db: 容器来源名
    # logging设置增加labels.service
    logging:
      options:
        labels: "service"
 
重新启动应用，然后访问http://ip:5601 重新添加索引。查看日志，可以增加过滤条件 attrs.service:db,此时查看到的日志就全部来自db容器















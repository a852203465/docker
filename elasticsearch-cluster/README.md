简介：
es-master：master节点，确定分片位置，索引的新增、删除请求分配
es-node1：分片的 CRUD，以及搜索和整合操作
es-node2：分片的 CRUD，以及搜索和整合操作
es-head：es的一个插件，目前官方版本只支持5.0。可以浏览和查看数据，可以类比于navcate相对于mysql的作用。

1. master配置文件
http.cors.enabled: true
http.cors.allow-origin: "*"
上面的配置是为了使es-head能连接到es集群

2. node配置文件
node1 的配置和node2的配置基本一致


3. 执行命令
docker-compose up 

4. ES-HEAD访问
ip:9100
实线部分为主分片，虚线部分为副本分片。  上图5个主分片和5个副本分片。 创建索引时候可以制定主分片和副本分片的个数， 默认情况下 5个主分片。1个副本分片（即每个主分片一个副本分片）

5. 相关问题整理

5.1目录无限问题
即：java.nio.file.AccessDeniedException: /usr/share/elasticsearch/data/nodes
相关目录上执行 chown 1000:1000 data

5.2启动失败问题
即：ERROR: [1] bootstrap checks failed
[1]: max virtual memory areas vm.max_map_count [65530] is too low, increase to at least [262144]
原因：最大虚拟内存太小,需要修改系统变量的最大值。
对应机器上执行  sudo sysctl -w vm.max_map_count=262144

6. max number of threads [1024] for user [es] likely too low, increase to at least [2048]
原因：无法创建本地线程问题,用户最大可创建线程数太小
解决方案：切换到root用户，进入limits.d目录下，修改90-nproc.conf 配置文件。
vi /etc/security/limits.d/90-nproc.conf
找到如下内容：
* soft nproc 1024
#修改为
* soft nproc 2048

7. system call filters failed to install; check the logs and fix your configuration or disable system call filters at your own risk
原因：Centos6不支持SecComp，而ES6.4.2默认bootstrap.system_call_filter为true进行检测，所以导致检测失败，失败后直接导致ES不能启动。
详见 ：https://github.com/elastic/elasticsearch/issues/22899

解决方法：在elasticsearch.yml中新增配置bootstrap.system_call_filter，设为false，注意要在Memory下面:

bootstrap.memory_lock: false
bootstrap.system_call_filter: false












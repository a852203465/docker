## 启动集群
docker-compose up -d

## 查看集群是否启动成功
docker-compose ps

## 检查zool集群状态

### zoo1
1. 进入容器：docker exec -it zoo1 /bin/sh
2. 执行命令：zkServer.sh status
    输出：ZooKeeper JMX enabled by default
                Using config: /conf/zoo.cfg
                Mode: follower                  // 这是个follower

### zoo2
1. 进入容器：docker exec -it zoo2 /bin/sh
2. 执行命令：zkServer.sh status
    输出：ZooKeeper JMX enabled by default
                Using config: /conf/zoo.cfg
                Mode: follower                  // 这是个follower

### zoo3
1. 进入容器：docker exec -it zoo3 /bin/sh
2. 执行命令：zkServer.sh status
    输出：ZooKeeper JMX enabled by default
                Using config: /conf/zoo.cfg
                Mode: follower                  // 这是个leader

## 验证kafka集群
1. 进入容器：docker exec -it broker1 bash
2. cd /opt/kafka_2.11-2.0.0/bin/
3. ./kafka-topics.sh --create --zookeeper zoo1:2181 --replication-factor 1 --partitions 8 --topic test
3. ./kafka-console-producer.sh --broker-list localhost:9092 --topic test

一般情况下上面这种就能验证集群了，但是在此处会抛出如下异常
```java
bash-4.4# kafka-topics.sh --create --zookeeper zoo1:2181 --replication-factor 1 --partitions 1 --topic mykafka
Error: Exception thrown by the agent : java.rmi.server.ExportException: Port already in use: 9977; nested exception is: 
        java.net.BindException: Address in use (Bind failed)
sun.management.AgentConfigurationError: java.rmi.server.ExportException: Port already in use: 9977; nested exception is: 
        java.net.BindException: Address in use (Bind failed)
        at sun.management.jmxremote.ConnectorBootstrap.startRemoteConnectorServer(ConnectorBootstrap.java:480)
        at sun.management.Agent.startAgent(Agent.java:262)
        at sun.management.Agent.startAgent(Agent.java:452)
Caused by: java.rmi.server.ExportException: Port already in use: 9977; nested exception is: 
        java.net.BindException: Address in use (Bind failed)
        at sun.rmi.transport.tcp.TCPTransport.listen(TCPTransport.java:346)
        at sun.rmi.transport.tcp.TCPTransport.exportObject(TCPTransport.java:254)
        at sun.rmi.transport.tcp.TCPEndpoint.exportObject(TCPEndpoint.java:411)
        at sun.rmi.transport.LiveRef.exportObject(LiveRef.java:147)
        at sun.rmi.server.UnicastServerRef.exportObject(UnicastServerRef.java:237)
        at sun.rmi.registry.RegistryImpl.setup(RegistryImpl.java:213)
        at sun.rmi.registry.RegistryImpl.<init>(RegistryImpl.java:173)
        at sun.management.jmxremote.SingleEntryRegistry.<init>(SingleEntryRegistry.java:49)
        at sun.management.jmxremote.ConnectorBootstrap.exportMBeanServer(ConnectorBootstrap.java:816)
        at sun.management.jmxremote.ConnectorBootstrap.startRemoteConnectorServer(ConnectorBootstrap.java:468)
        ... 2 more
Caused by: java.net.BindException: Address in use (Bind failed)
        at java.net.PlainSocketImpl.socketBind(Native Method)
        at java.net.AbstractPlainSocketImpl.bind(AbstractPlainSocketImpl.java:387)
        at java.net.ServerSocket.bind(ServerSocket.java:375)
        at java.net.ServerSocket.<init>(ServerSocket.java:237)
        at java.net.ServerSocket.<init>(ServerSocket.java:128)
        at sun.rmi.transport.proxy.RMIDirectSocketFactory.createServerSocket(RMIDirectSocketFactory.java:45)
        at sun.rmi.transport.proxy.RMIMasterSocketFactory.createServerSocket(RMIMasterSocketFactory.java:345)
        at sun.rmi.transport.tcp.TCPEndpoint.newServerSocket(TCPEndpoint.java:666)
        at sun.rmi.transport.tcp.TCPTransport.listen(TCPTransport.java:335)
        ... 11 more
```

## 解决方法
1. 在每一个kafka节点加上环境变量 JMX_PORT=端口

2. 在命令之前先重置一下unset JMX_PORT；

3. ./kafka-topics.sh -create --zookeeper zoo1:2181/kafka1,zoo2:2181/kafka1,zoo3:2181/kafka1 --replication-factor 1 --partitions 1 --topic mykafka

## 可视化验证

我们打开kafka-manager的管理页面，访问路径是，宿主机ip:9000

填写上Zookeeper集群的地址，划到最下边点击save
(zoo1:2181/kafka1,zoo2:2181/kafka1,zoo3:2181/kafka1)




































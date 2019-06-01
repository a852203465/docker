安装步骤：

准备maven环境；
下载ik分词器源码；
编译构建源码；
编译结果是个zip包，复制到elasticsearch的插件目录去解压；
启动elasticsearch；

1. 写Dockerfile文件

已写好不再赘述了

2. 构建镜像

docker build -t a852203465/elasticsearch-with-ik:6.5.0 .

2.1 查看构建信息

执行命令docker history a852203465/elasticsearch-with-ik:6.5.0

3. 运行docker-compose 文件

docker-compose up -d

4. 问题解决

4.1目录无权限问题

即：java.nio.file.AccessDeniedException: /usr/share/elasticsearch/data/nodes
相关目录上执行 chown 1000:1000 data
sudo chmod -R 777 data/

















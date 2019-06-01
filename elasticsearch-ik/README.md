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
    
注意：elasticsearch 和 elasticsearch-analysis-ik 版本一定要相同的，否则会启动失败
    
2.1 查看构建信息

执行命令docker history a852203465/elasticsearch-with-ik:6.5.0

3. 运行docker-compose 文件

docker-compose up -d

4. 问题解决

4.1目录无权限问题

即：java.nio.file.AccessDeniedException: /usr/share/elasticsearch/data/nodes

相关目录上执行 chown 1000:1000 data

sudo chmod -R 777 data/

5. 验证分词效果

5.1 假设docker所在电脑的IP地址是192.168.1.101，执行以下命令来创建一个索引：

curl -X PUT http://192.168.1.101:9200/test001

5.2 执行以下命令验证ik分词器效果：

curl -X POST \
'http://192.168.1.101:9200/test001/_analyze?pretty=true' \
-H 'Content-Type: application/json' \
-d '{"text":"我们是软件工程师","tokenizer":"ik_smart"}'

收到的相应如下，可见ik分词器已经生效：

{
  "tokens" : [
    {
      "token" : "我们",
      "start_offset" : 0,
      "end_offset" : 2,
      "type" : "CN_WORD",
      "position" : 0
    },
    {
      "token" : "是",
      "start_offset" : 2,
      "end_offset" : 3,
      "type" : "CN_CHAR",
      "position" : 1
    },
    {
      "token" : "软件",
      "start_offset" : 3,
      "end_offset" : 5,
      "type" : "CN_WORD",
      "position" : 2
    },
    {
      "token" : "工程师",
      "start_offset" : 5,
      "end_offset" : 8,
      "type" : "CN_WORD",
      "position" : 3
    }
  ]
}














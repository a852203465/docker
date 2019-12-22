# 基础镜像
FROM ubuntu:16.04

### 作者信息
LABEL maintainer="852203465@qq.com"
LABEL version="1.0"
LABEL description="流媒体服务器"

# 修改软件源  ubuntu:16.04
RUN sed -i s@/archive.ubuntu.com/@/mirrors.aliyun.com/@g /etc/apt/sources.list
# ADD sources.list /etc/apt/

# 安装gcc g++
RUN apt-get update --fix-missing\
        && apt-get -y install gcc --fix-missing\
        && apt-get -y install g++ --fix-missing

# 复制easydarwin
COPY  ./EasyDarwin-linux-8.1.0-1901141151.tar.gz /home

# 解压
RUN tar zxvf /home/EasyDarwin-linux-8.1.0-1901141151.tar.gz -C /home\
        && mv /home/EasyDarwin-linux-8.1.0-1901141151 /home/easydarwin

# 切换工作目录
WORKDIR /home/easydarwin

# 可执行权限
RUN  chmod +x start.sh stop.sh

# 暴露端口
EXPOSE 10008
EXPOSE 554

# 启动服务
ENTRYPOINT ["./easydarwin"]
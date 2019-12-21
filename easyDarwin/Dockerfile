# 基础镜像
FROM ubuntu:16.04

### 作者信息
LABEL maintainer="852203465@qq.com"
LABEL version="1.0"
LABEL description="流媒体服务器"

# 修改软件源
RUN sed -i s@/archive.ubuntu.com/@/mirrors.aliyun.com/@g /etc/apt/sources.list
# ADD sources.list /etc/apt/

RUN apt-get update --fix-missing\
	&& apt-get -y install gcc --fix-missing\
	&& apt-get -y install g++ --fix-missing

COPY  ./EasyDarwin-linux-8.1.0-1901141151.tar.gz /home

RUN tar zxvf /home/EasyDarwin-linux-8.1.0-1901141151.tar.gz -C /home\
	&& mv /home/EasyDarwin-linux-8.1.0-1901141151 /home/easydarwin

WORKDIR /home/easydarwin

RUN  chmod +x start.sh stop.sh

EXPOSE 10008
EXPOSE 554

ENTRYPOINT ["./easydarwin"]



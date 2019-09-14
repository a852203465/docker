FROM nginx

RUN sed -i s/archive.ubuntu.com/mirrors.aliyun.com/g /etc/apt/sources.list \
    && sed -i s/security.ubuntu.com/mirrors.aliyun.com/g /etc/apt/sources.list \
    && apt-get update
RUN apt-get install ntp -y
ADD ./entrypoint.sh /bin/entrypoint.sh
ADD ./ntp.conf /etc/ntp.conf
CMD ["sh", "/bin/entrypoint.sh"]

ENV TZ=Asia/Shanghai
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone


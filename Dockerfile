FROM tars-master:base

WORKDIR /root/

##修改镜像时区 
ENV TZ=Asia/Shanghai

ENV DBIP 127.0.0.1
ENV DBPort 3306
ENV DBUser root
ENV DBPassword password

# Mysql里tars用户的密码，缺省为tars2015
ENV DBTarsPass tars2015

##安装
RUN mkdir -p /usr/local/app/patchs/tars.upload \
	&& mkdir -p /root/init && cd /root/init/ 

# 是否将Tars系统进程的data目录挂载到外部存储，缺省为false以支持windows下使用
ENV MOUNT_DATA false

# 网络接口名称，如果运行时使用 --net=host，宿主机网卡接口可能不叫 eth0
ENV INET_NAME eth0

# 中文字符集支持
#ENV LC_ALL "zh_CN.UTF-8"

VOLUME ["/data"]

##拷贝资源
COPY install.sh /root/init/
COPY entrypoint.sh /sbin/

ADD confs /root/confs

#ADD pid1-0.1.0-amd64 /sbin/pid1
RUN chmod 755 /sbin/entrypoint.sh
#ENTRYPOINT [ "/sbin/pid1" ]
ENTRYPOINT [ "/sbin/entrypoint.sh" , "start" ]

#Expose ports
EXPOSE 3000

FROM million12/centos-supervisor
MAINTAINER "samsixtyone" <sam.sixtyone@gmail.com>
ENV container docker
RUN yum -y install wget vim git initscripts sudo; \
yum -y update; \
yum -y install java-1.8.0-openjdk nginx nodejs npm; \
mkdir -p /etc/nginx/ssl; mkdir /app;

COPY ssl.conf /etc/nginx/conf.d/ssl.conf
COPY server.crt /etc/nginx/ssl/server.crt
COPY server.key /etc/nginx/ssl/server.key
COPY nginx /etc/init.d/nginx
COPY sudoers /etc/sudoers
COPY peek.conf /etc/supervisor.d/peek.conf
RUN rpm --import http://pkg.jenkins-ci.org/redhat/jenkins-ci.org.key; \
wget -O /etc/yum.repos.d/jenkins.repo http://pkg.jenkins-ci.org/redhat/jenkins.repo; \
yum -y install jenkins; yum clean all;

EXPOSE 443 8080 

RUN cd /app; git clone https://github.com/ccoenraets/directory-react-nodejs.git
RUN cd /app/directory-react-nodejs; npm install --production

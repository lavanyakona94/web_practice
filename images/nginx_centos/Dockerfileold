FROM centos:8


RUN yum -y update
RUN yum -y install nginx

ENTRYPOINT ["/usr/sbin/nginx", "-g", "daemon off;"]

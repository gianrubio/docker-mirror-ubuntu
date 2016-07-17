FROM ubuntu

RUN apt-get update
RUN DEBIAN_FRONTEND=noninteractive apt-get install nginx -y
RUN rm -rf /var/lib/apt/lists/*

# configure nginx
RUN sed -i '/^daemon/d' /etc/nginx/nginx.conf # revisar
RUN sed -i '/^worker_processes/a daemon off;' /etc/nginx/nginx.conf
RUN sed -i '/^http/a limit_req_zone \$binary_remote_addr zone\=one\:10m rate\=10r\/s\;' /etc/nginx/nginx.conf
RUN rm -f /etc/nginx/sites-enabled/default
ADD nginx-ubuntu-mirror.conf /etc/nginx/sites-enabled/
RUN cd /etc/nginx/sites-enabled/ && ln -s ubuntu-mirror.conf ../sites-available

VOLUME [ "/data/"]
EXPOSE 80
CMD service nginx start

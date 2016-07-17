FROM ubuntu

RUN apt-get update
RUN DEBIAN_FRONTEND=noninteractive apt-get install apt-mirror cron -y
RUN rm -rf /var/lib/apt/lists/*

# configure ubuntu mirror
RUN mkdir -p /data/mirror/www
RUN chown -R www-data: /data
RUN echo "set base_path /data/mirror" >> /etc/apt/mirror.list
RUN echo "set mirror_path /data/mirror/www" >> /etc/apt/mirror.list
ADD cron-apt-mirror /etc/cron.d/apt-mirror
RUN chmod 0644 /etc/cron.d/apt-mirror

VOLUME [ "/data/"]
CMD cron
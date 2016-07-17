FROM ubuntu

RUN apt-get update
RUN DEBIAN_FRONTEND=noninteractive apt-get install apt-mirror cron -y
RUN rm -rf /var/lib/apt/lists/*

# configure ubuntu mirror
RUN mkdir -p /data/mirror/www
RUN chown -R www-data: /data
RUN echo "set base_path /data/mirror" >> /etc/apt/mirror.list
RUN echo "set mirror_path /data/mirror/www" >> /etc/apt/mirror.list

WORKDIR /sync
ADD daemon-apt-mirror.sh .
RUN chmod +x daemon-apt-mirror.sh

VOLUME [ "/data/"]

CMD ./daemon-apt-mirror.sh
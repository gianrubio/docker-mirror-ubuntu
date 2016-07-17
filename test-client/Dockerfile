FROM ubuntu

RUN sed -i 's/archive\.ubuntu\.com/www-server/g' /etc/apt/sources.list
ADD wait-sync-server-finish.sh .
RUN chmod +x /wait-sync-server-finish.sh
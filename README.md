#Ubuntu docker mirror

# CI [![CircleCI](https://circleci.com/gh/gianrubio/docker-mirror-ubuntu/tree/master.svg?style=svg&circle-token=c63bcdcabe6985b72ce3538934175b796ce27562)](https://circleci.com/gh/gianrubio/docker-mirror-ubuntu/tree/master)

Every push on master branch will call a webhook to [circleci](https://circleci.com/gh/gianrubio/docker-mirror-ubuntu/) and build a docker image. 
When the CI successfully run, it will push docker images to docker hub. More info on [circle.yml](blob/master/circle.yml#L25-27)

# Architecture

This applications has the concept of [microservices](http://martinfowler.com/articles/microservices.html).
There are 3 docker images, each one it's a specialized service that run *only one task*. The orchestration are managed by [docker-compose](blob/master/docker-compose.yml). 

* [sync-mirror-server](blob/master/sync-mirror-server/Dockerfile)
Simple daemon that download mirror files from ubuntu archive. When the mirror finish the sync, it will create a new file that was shared with test-client.
This daemon sync files every day.

[www-server](blob/master/www-server/Dockerfile)
HTTP Server responsible to provide synced mirror files using nginx.

[test-client](blob/master/test-client/Dockerfile)
A docker image to proof that the architecture of the app will work. This image will wait mirror server to finish the sync, using a [shared file](blob/master/test-client/wait-sync-server-finish.sh). 

# Setup project

1. To run this application you need to clone this repo, setup [docker](https://docs.docker.com/engine/installation/) and [docker-compose](https://docs.docker.com/compose/install/).

2. Start docker-compose
```
docker-compose up
```
3. Wait the magical happen. 
  1. sync-mirror-server will start the sync.
  2. www-server will get up.
  3. test-client will wait sync server to finish and simply run apt-get update. 
 
# Project requirements

* A volume on the host system containing an initial checkout of a mirror is available and mounted into the container on the mountpoint / data / mirror;

```
mounted volume /data, shared across servers sync and www.
```

* The data volume needs to be synced daily from the upstream mirror

Look on file [sync-mirror-server/daemon-apt-mirror.sh](blob/master/www-server/nginx-ubuntu-mirror.conf#L6-L11)

* Implement rate limiting (10 requests per second per client)
File [nginx.conf](blob/master/www-server/Dockerfile#L10)

```
limit_req_zone \$binary_remote_addr zone\=one\:10m rate\=10r
```

* Only machines from the local RFC1918 range may access the mirror
File [www-server/nginx-ubuntu-mirror.conf](blob/master/www-server/nginx-ubuntu-mirror.conf#L6-L11)

```
# Allow localhost (RFC990) and private networks (RFC1918)
allow                   127.0.0.0/8;
allow                   10.0.0.0/8;
allow                   172.16.0.0/12;
allow                   192.168.0.0/16;
deny                    all;
```

* Some method of being able to externally check the health of the service
File [www-server/nginx-ubuntu-mirror.conf](blob/master/www-server/nginx-ubuntu-mirror.conf#L16-L19)

```
  location /healtcheck {
    return 200 'OK!';
    add_header Content-Type text/plain;
  }
```
* Adhere as much as you can to the 12-factor app development guidelines (http://12factor.net).
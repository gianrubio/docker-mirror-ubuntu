#ubuntu docker mirror

# CI status
[![CircleCI](https://circleci.com/gh/gianrubio/docker-mirror-ubuntu/tree/master.svg?style=svg&circle-token=c63bcdcabe6985b72ce3538934175b796ce27562)](https://circleci.com/gh/gianrubio/docker-mirror-ubuntu/tree/master)

To run this docker mirror you need to setup (docker)[https://docs.docker.com/engine/installation/] and (docker-compose)[https://docs.docker.com/compose/install/]


# Project requirements

* A volume on the host system containing an initial checkout of a mirror is available and mounted into the container on the mountpoint / data / mirror;
* The data volume needs to be synced daily from the upstream mirror
* Implement rate limiting (10 requests per second per client);
* Only machines from the local RFC1918 range may access the mirror;
* Some method of being able to externally check the health of the service;
* Adhere as much as you can to the 12-factor app development guidelines (http://12factor.net).
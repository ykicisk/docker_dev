# docker_dev
docker files for dev environment ( centos7 )

## setup

```
# install berkshelf
$ gem i berkshelf --no-ri --no-rdoc

# get external cookbooks
$ cd chef
$ berks vendor cookbooks
```

## docker build

```
$ docker build -t centos:dev .
```

## docker run

```
$ docker run -it --rm -u docker centos:dev /bin/bash
```

# docker_dev
docker files for dev environment ( centos7 )

## setup

```
# install berkshelf
$ gem i berkshelf --no-ri --no-rdoc

# get external cookbooks
$ cd chef
$ berks vendor cookbooks

# setting ~/.ssh/config

$ cat ~/.ssh/config
Host docker
    HostName localhost
    User docker
    StrictHostKeyChecking no
    Port 2222
```

if you use docker-machine, you

## docker build

```
$ docker build -t ubuntu:dev .
```

## docker run

```
$ docker run -it centos:dev /bin/zsh
```


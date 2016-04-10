# docker_dev
docker files for development environment (ubuntu)

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

if you use docker-machine on virtual box, 
you must set following port-forwarding option.

![virtual box setting](https://raw.githubusercontent.com/ykicisk/docker_dev/images/images/vbox_setting.png)


## docker build

```
$ docker build -t ubuntu:dev .
```

## docker run

```
$ docker run -d -p 2222:22 ubuntu:dev
```

## ssh
```
# password is "docker"
$ ssh docker
```


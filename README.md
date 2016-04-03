# docker_dev
docker files for dev environment ( centos7 )

## setup

```
$ gem i berkshelf --no-ri --no-rdoc
$ cd chef
$ berks vendor cookbooks
```

## docker build

```
$ docker build -t centos:dev .
```



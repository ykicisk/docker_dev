FROM centos:7.2.1511
 
# select a file in ${CHEFHOME}/nodes
ENV CHEFTARGET dev.json
# ENV CHEFTARGET chainer.json
ENV CHEFHOME /chef

# add docker user
RUN useradd -m -d /home/docker -s /bin/bash docker \
  && echo "docker:docker" | chpasswd \
  && mkdir -p /home/docker/.ssh \
  && chmod 700 /home/docker/.ssh
RUN echo "root ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers
RUN echo "docker ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers
COPY . /home/docker/.docker
RUN chown -R docker:docker /home/docker

# install essential tools
RUN yum -y update
RUN yum -y groupinstall base
RUN yum -y groupinstall core
RUN yum -y groupinstall "Development Tools"

# install chef
RUN curl -L http://www.opscode.com/chef/install.sh | bash
COPY chef /chef
RUN cd ${CHEFHOME} && chef-solo -c ${CHEFHOME}/solo.rb -j ${CHEFHOME}/nodes/${CHEFTARGET}

# run chef as docker
USER docker
WORKDIR /home/docker
ENV HOME /home/docker
ENV LANG C.UTF-8
ENV TERM xterm-256color

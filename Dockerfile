FROM ubuntu:latest

# chef provision setting
# select a file in ${CHEFHOME}/nodes
ENV CHEFTARGET dev.json
# ENV CHEFTARGET chainer.json
ENV CHEFHOME /chef

# ssh setting
RUN apt-get update && apt-get install -y openssh-server
RUN mkdir /var/run/sshd
RUN echo 'root:screencast' | chpasswd
RUN sed -i 's/PermitRootLogin without-password/PermitRootLogin yes/' /etc/ssh/sshd_config

# SSH login fix. Otherwise user is kicked off after login
RUN sed 's@session\s*required\s*pam_loginuid.so@session optional pam_loginuid.so@g' -i /etc/pam.d/sshd

ENV NOTVISIBLE "in users profile"
RUN echo "export VISIBLE=now" >> /etc/profile

EXPOSE 22
EXPOSE 8888
CMD ["/usr/sbin/sshd", "-D"]

# add docker user
RUN useradd -m -d /home/docker -s /bin/bash docker \
  && echo "docker:docker" | chpasswd \
  && mkdir -p /home/docker/.ssh \
  && chmod 700 /home/docker/.ssh
RUN echo "root ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers
RUN echo "docker ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers
COPY . /home/docker/.docker
RUN mkdir -p /home/docker/share
RUN chown -R docker:docker /home/docker

WORKDIR /home/docker
ENV HOME /home/docker

# provision by chef
RUN apt-get install -y curl build-essential
RUN curl -L http://www.opscode.com/chef/install.sh | bash
COPY chef /chef
RUN cd ${CHEFHOME} && chef-solo -c ${CHEFHOME}/solo.rb -j ${CHEFHOME}/nodes/${CHEFTARGET}


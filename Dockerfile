FROM centos:7.2.1511
 
ENV CHEFHOME /chef
# select a file in ${CHEFHOME}/nodes
ENV TARGET dev.json

ADD chef /chef
 
RUN curl -L http://www.opscode.com/chef/install.sh | bash
RUN cd ${CHEFHOME} && chef-solo -c ${CHEFHOME}/solo.rb -j ${CHEFHOME}/nodes/${TARGET}

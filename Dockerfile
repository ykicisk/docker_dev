FROM centos:7.2.1511
 
ENV CHEFHOME /chef-repo
# select a file in ${CHEFHOME}/nodes
ENV TARGET dev.json

ADD chef-repo /chef-repo
 
RUN curl -L http://www.opscode.com/chef/install.sh | bash
RUN cd ${CHEFHOME} && chef-solo -c ${CHEFHOME}/solo.rb -j ${CHEFHOME}/nodes/${TARGET}

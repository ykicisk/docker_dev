#
# Cookbook Name:: chainer
# Recipe:: default
#
# Copyright 2015, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

include_recipe "python"

package ["libjpeg-turbo-devel","zlib-devel","hdf5-devel"]

# install packages
python_pip 'six' do
  action :upgrade
end
python_pip 'numpy'
python_pip 'pillow'
python_pip 'chainer'

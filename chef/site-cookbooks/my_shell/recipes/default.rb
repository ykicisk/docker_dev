#
# Cookbook Name:: my_shell
# Recipe:: default
#
# Copyright 2015, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

package ['zsh', 'tmux', 'git']

# copy dotfiles (setup by submodule)
# git node[cookbook_name]['dotfiles_dst'] do
#   repository node[cookbook_name]['dotfiles_repo']
#   revision 'master'
#   user 'docker'
#   group 'docker'
#   action :sync
# end
['.zshrc', '.tmux.conf', '.vimrc'].each do |fname| 
  link "#{node[cookbook_name]['home']}/#{fname}" do
    to "#{node[cookbook_name]['dotfiles_dst']}/#{fname}"
  end
end
# change shell
# bash "Set docker's shell to zsh" do
#   code <<-EOT
#     chsh -s /bin/zsh docker
#   EOT
#   not_if 'test "/bin/zsh" = "$(grep docker /etc/passwd | cut -d: -f7)"'
# end  

# install zplug
git "#{node[cookbook_name]['home']}/.zplug" do
  repository "https://github.com/b4b4r07/zplug"
  revision 'master'
  user 'docker'
  group 'docker'
  action :sync
end
 
# install neobundle
directory "#{node[cookbook_name]['home']}/.vim/bundle" do
  user 'docker'
  group 'docker'
  recursive true
  action :create
end
git "#{node[cookbook_name]['home']}/.vim/bundle/neobundle.vim" do
  repository "https://github.com/Shougo/neobundle.vim"
  revision 'master'
  user 'docker'
  group 'docker'
  action :sync
end
bash "install vim plugins" do
  code <<-EOT 
    sudo -u docker #{node[cookbook_name]['home']}/.vim/bundle/neobundle.vim/bin/neoinstall
  EOT
  # code <<-EOT "#{node[cookbook_name]['home']}/.vim/bundle/neobundle.vim/bin/neoinstall" EOT
  not_if { File.exists?("#{node[cookbook_name]['home']}/.vim/bundle/molokai") }
end
# cp molokai theme
directory "#{node[cookbook_name]['home']}/.vim/colors" do
  user 'docker'
  group 'docker'
  recursive true
  action :create
end
file "#{node[cookbook_name]['home']}/.vim/colors/molokai.vim" do
  content lazy {IO.read("#{node[cookbook_name]['home']}/.vim/bundle/molokai/colors/molokai.vim")}
  user 'docker'
  group 'docker'
end

#
# Cookbook Name:: my_shell
# Recipe:: default
#
# Copyright 2015, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

package ['zsh', 'tmux', 'git']

# copy dotfiles
git node[cookbook_name]['dotfiles_dst'] do
  repository node[cookbook_name]['dotfiles_repo']
  revision 'master'
  user 'vagrant'
  group 'vagrant'
  action :sync
end
['.zshrc', '.tmux.conf', '.vimrc'].each do |fname| 
  link "#{node[cookbook_name]['home']}/#{fname}" do
    to "#{node[cookbook_name]['dotfiles_dst']}/#{fname}"
  end
end

# change shell
bash "Set vagrant's shell to zsh" do
  code <<-EOT
    chsh -s /bin/zsh vagrant
  EOT
  not_if 'test "/bin/zsh" = "$(grep vagrant /etc/passwd | cut -d: -f7)"'
end  

# install neobundle
directory "#{node[cookbook_name]['home']}/.vim/bundle" do
  user 'vagrant'
  group 'vagrant'
  recursive true
  action :create
end
git "#{node[cookbook_name]['home']}/.vim/bundle/neobundle.vim" do
  repository "https://github.com/Shougo/neobundle.vim"
  revision 'master'
  user 'vagrant'
  group 'vagrant'
  action :sync
end
bash "install vim plugins" do
  code <<-EOT 
    sudo -u vagrant #{node[cookbook_name]['home']}/.vim/bundle/neobundle.vim/bin/neoinstall
  EOT
  # code <<-EOT "#{node[cookbook_name]['home']}/.vim/bundle/neobundle.vim/bin/neoinstall" EOT
  not_if { File.exists?("#{node[cookbook_name]['home']}/.vim/bundle/molokai") }
end
# cp molokai theme
directory "#{node[cookbook_name]['home']}/.vim/colors" do
  user 'vagrant'
  group 'vagrant'
  recursive true
  action :create
end
file "#{node[cookbook_name]['home']}/.vim/colors/molokai.vim" do
  content lazy {IO.read("#{node[cookbook_name]['home']}/.vim/bundle/molokai/colors/molokai.vim")}
  user 'vagrant'
  group 'vagrant'
end

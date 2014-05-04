#
# Cookbook Name:: devenv
# Recipe:: default
#
# Copyright (C) 2014 YOUR_NAME
#
# All rights reserved - Do Not Redistribute
#
include_recipe 'apt'
include_recipe 'golang'
include_recipe 'zsh'

username = 'vagrant'

user 'vagrant' do
  shell '/usr/bin/zsh'
  action :modify
end

git "/home/#{username}/.dotfiles" do
  user username
  repository "https://github.com/pyraz/dotfiles.git"
  reference "master"
end

bash "link dotfiles" do
  user username
  cwd "/home/#{username}"
  code <<-LINK_DOTFILES
      echo "********* Linking Dotfiles **********"
      if [ ! -e '.gitconfig' ]; then
        ln -s /home/#{username}/.dotfiles/.gitconfig .gitconfig
      fi

      if [ ! -e '.tmux.conf' ]; then
        ln -s /home/#{username}/.dotfiles/.tmux.conf .tmux.conf
      fi
  LINK_DOTFILES
end

git "/home/#{username}/.zshrc" do
  user username
  repository "https://github.com/pyraz/oh-my-zsh.git"
  reference "master"
end

bash "link zshrc file" do
  user username
  cwd "/home/#{username}"
  code <<-LINK_DOTFILES
      echo "********* Linking Zshell Config **********"
      if [ ! -e '.zshrc' ]; then
        ln -s /home#{username}/.oh-my-zsh/zshrc .zshrc
      fi
  LINK_DOTFILES
end

git "/home/#{username}/.vim" do
  user username
  repository "https://github.com/pyraz/vim-config.git"
  reference "master"
end

bash "install vim" do
  cwd "/home/#{username}/.vim"
  user "root"
  code <<-INSTALL_VIM
      echo "********** Installing Vim **********"
      scripts/install_vim.sh
  INSTALL_VIM
end

bash "install dependencies for YouCompleteMe" do
  cwd "/home/#{username}"
  user "root"
  code <<-INSTALL_DEPENDENCIES
      echo "************ Installing YouCompleteMe Dependencies *********"
      apt-get install -qy build-essential cmake python-dev
  INSTALL_DEPENDENCIES
end

bash "configure vim" do
  cwd "/home/#{username}/.vim"
  user username
  code <<-CONFIGURE_VIM
      echo "********* Configuring Vim *********"
      git submodule update --init
      cd bundle/YouCompleteMe
      git submodule update --init --recursive
      ./install.sh
  CONFIGURE_VIM
end

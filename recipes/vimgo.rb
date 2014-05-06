#
# Cookbook Name:: devenv
# Recipe:: vimgo
#
# Copyright (C) 2014 Trevor Whitney
#
# All rights reserved - Do Not Redistribute
#
username = node['devenv']['user']

bash "copy vimgo binaries" do
  user "root"
  group "root"
  cwd "/home/#{username}/workspace/go"
  code <<-VIM_GO_BINARIES
    go get github.com/nsf/gocode
    go get code.google.com/p/go.tools/cmd/goimports
    go get code.google.com/p/rog-go/exp/cmd/godef
    go get code.google.com/p/go.tools/cmd/oracle
    go get github.com/golang/lint/golint
    go get github.com/kisielk/errcheck
    mkdir /home/#{username}/.vim-go
    which gocode
    which goimports
    which godef
    which oracle
    which golint
    which errcheck
    cp bin/errcheck bin/gocode bin/goimports bin/godef bin/oracle bin/golint \
      /home/#{username}/.vim-go
  VIM_GO_BINARIES
end

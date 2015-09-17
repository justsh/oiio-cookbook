#
# Cookbook Name:: oiio
# Recipe:: build
#
# Copyright (c) 2015 The Authors, All Rights Reserved.

include_recipe "apt::default"
include_recipe "git::default"
include_recipe 'build-essential::default'

# https://sites.google.com/site/openimageio/checking-out-and-building-openimageio

node["oiio"]["package_dependencies"].each do |p|
    package p
end

compile_command = "make"
compile_env = { "USE_OPENGL" => "0" }


if node["oiio"]["install_extras"]
    node["oiio"]["package_extras"].each do |p|
        package p
    end

    compile_env["USE_OPENGL"] = "1"
end


git node["oiio"]["source"]["git_destination"] do
  repository node["oiio"]["source"]["git_repository"]
  reference node["oiio"]["source"]["git_revision"]
  action :sync
  notifies :run, "execute[make_realclean]", :immediately
end


if node["oiio"]["install_tests"]
    compile_command = "make test"
    git node["oiio"]["test_source"]["git_destination"] do
      repository node["oiio"]["test_source"]["git_repository"]
      reference node["oiio"]["test_source"]["git_revision"]
      action :sync
    end
end


execute 'make_realclean' do
  cwd node["oiio"]["source"]["git_destination"]
  command "make realclean > make.log"
  action :nothing
end



execute 'compile_oiio' do
  cwd node["oiio"]["source"]["git_destination"]
  command "#{compile_command} > make.log"
  environment compile_env
  # NOTE: This could be much more robust, possibly comparing the values of the
  # environment variables in version.h to the value of libOpenImageIO.so.#.#.#
  # (major, minor, patch)
  not_if { ::File.exists?("#{node["oiio"]["source"]["git_destination"]}/dist/linux64/include/OpenImageIO/version.h") }
end

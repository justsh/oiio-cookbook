#
# Cookbook Name:: oiio
# Recipe:: install
#
# Copyright (c) 2015 The Authors, All Rights Reserved.


dist64_dir = "#{node["oiio"]["source"]["git_destination"]}/dist/linux64"
install_dir = ""  # the empty string will default to root

execute 'install_oiio' do
  cwd dist64_dir
  command "rsync -a #{dist64_dir}/ #{install_dir}/"
  # NOTE: This could be much more robust, possibly comparing the values of the
  # environment variables in version.h to the value of libOpenImageIO.so.#.#.#
  # (major, minor, patch)
  only_if { ::File.exists?("#{dist64_dir}/include/OpenImageIO/version.h") }
  not_if { ::File.exists?("#{install_dir}/include/OpenImageIO/version.h") }
end

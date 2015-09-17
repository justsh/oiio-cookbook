#
# Cookbook Name:: OpenImageIO
# Recipe:: default
#
# Copyright 2013, Justin Sheehy
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

default["oiio"]["source"] = {
  "git_repository" => "https://github.com/OpenImageIO/oiio.git",
  "git_revision" => "RB-1.3",
  "git_destination" => "#{Chef::Config[:file_cache_path]}/oiio"
}

# NOTE: zlib should be included in libpng-dev
default["oiio"]["package_dependencies"] = %w{
    cmake
    libpng-dev
    libjpeg-dev
    libtiff-dev
    libilmbase-dev
    libopenexr-dev
    libboost-dev
    libboost-filesystem-dev
    libboost-regex-dev
    libboost-system-dev
    libboost-thread-dev
}

default["oiio"]["install_extras"] = false
default["oiio"]["package_extras"] = %w{
    openexr-viewers
    libglu1-mesa-dev
    freeglut3-dev
    mesa-common-dev
    libglew-dev
    libqt4-dev
}

default["oiio"]["install_tests"] = false
default["oiio"]["test_source"] = {
  "git_repository" => "https://github.com/OpenImageIO/oiio-images",
  "git_revision" => node["oiio"]["source"]["git_revision"],
  "git_destination" => "#{Chef::Config[:file_cache_path]}/oiio-images"
}

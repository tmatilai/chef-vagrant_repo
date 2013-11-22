#
# Cookbook Name:: vagrant_repo
# Recipe:: apt
#
# Author:: Teemu Matilainen <teemu.matilainen@iki.fi>
#
# Copyright 2013, Teemu Matilainen
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

node.default['nginx']['default_site_enabled'] = false

include_recipe 'nginx'

root_dir = node['vagrant_repo']['apt']['root_dir']
suite_dir = File.join(root_dir, 'dists', node['vagrant_repo']['apt']['suite'])

packages = VagrantRepo::AptPackages.new(node)

directory suite_dir do
  owner 'root'
  group 'root'
  mode 00755
  recursive true
end

packages.architectures.each do |arch|
  directory packages.directory(arch) do
    owner 'root'
    group 'root'
    mode 00755
    recursive true
  end
end

pkg_indices = []
packages.group_by_arch.each do |arch, pkgs|
  r = template File.join(packages.directory(arch), 'Packages') do
    owner 'root'
    group 'root'
    mode 00644
    variables :packages => pkgs
  end
  pkg_indices << VagrantRepo::Hashfile.new(r.path)
end

template File.join(suite_dir, 'Release') do
  owner 'root'
  group 'root'
  mode 00644
  variables(
    :base_dir => suite_dir,
    :files => pkg_indices
  )
end

template File.join(node['nginx']['dir'], 'sites-available', 'vagrant-apt') do
  source 'apt.nginx.erb'
  owner 'root'
  group 'root'
  mode 00644
  notifies :reload, 'service[nginx]'
end

nginx_site 'vagrant-apt'

template File.join(root_dir, 'index.html') do
  source 'apt.html.erb'
  owner 'root'
  group 'root'
  mode 00644
end

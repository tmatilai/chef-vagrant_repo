#
# Cookbook Name:: vagrant_repo
# Attributes:: default
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

default['vagrant_repo']['apt']['root_dir'] = '/usr/local/vagrant-apt'

default['vagrant_repo']['apt']['server_name'] = node['fqdn']

default['vagrant_repo']['apt']['architectures'] = %w[amd64 i386]
default['vagrant_repo']['apt']['packages'] = [
  {
    'tag' => 'v1.3.5',
    'ref' => 'a40522f5fabccb9ddabad03d836e120ff5d14093',
    'amd64' => {
      'size' => '24386372',
      'md5'  => '371dcbb9c98523925197cd6ac2bb4e79'
    },
    'i386' => {
      'size' => '23470646',
      'md5' => '6dfb56147684541eef29ef2958ba7b84'
    }
  }
]

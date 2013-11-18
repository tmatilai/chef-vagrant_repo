#
# Cookbook Name:: vagrant_repo
# Library:: VagrantRepo::AptPackages
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

class VagrantRepo
  # Collection of AptPackage objects grouped by arch
  class AptPackages
    # @param [Chef::Node] node
    # @param [String] arch
    # @return [String] the arch specific absolute path
    def self.directory(node, arch)
      conf = node['vagrant_repo']['apt']
      File.join(conf['root_dir'], 'dists', conf['suite'],
                conf['component'], "binary-#{arch}")
    end

    attr_reader :archs, :packages

    # Constructs a list of packages based on node data
    def initialize(archs, data)
      @archs = archs
      @packages = []

      data.each { |release| add_packages(release) }
    end

    # @return [Hash] lists of {AptPackage} objects grouped by arch
    def group_by_arch
      packages.group_by(&:arch)
    end

    private

    def add_packages(release_data)
      archs.each do |arch|
        packages << package(arch, release_data) if release_data[arch]
      end
    end

    def package(arch, release_data)
      opts = {
        'arch' => arch,
        'ref'  => release_data['ref']
      }.merge(release_data[arch])
      AptPackage.new(release_data['tag'], opts)
    end
  end
end

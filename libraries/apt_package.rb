#
# Cookbook Name:: vagrant_repo
# Library:: VagrantRepo::AptPackage
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
  # Metadata for an Apt package
  class AptPackage
    attr_accessor :tag, :ref, :arch, :size, :md5

    # @param tag [String] the git tag of the package version
    # @param opts [Hash] other metadata
    def initialize(tag, opts = {})
      @tag     = tag
      @ref     = opts['ref']
      @arch    = opts['arch']
      @size    = opts['size']
      @md5     = opts['md5']
    end

    # @return [String] the package version without 'v' prefix
    def version
      tag.sub(/^v/, '')
    end

    # @return [String] the package version without 'v' prefix
    def path
      "#{ref}/vagrant_#{version}_#{package_arch}.deb"
    end

    private

    def package_arch
      case arch
      when 'amd64' then 'x86_64'
      when 'i386'  then 'i686'
      else arch
      end
    end
  end
end

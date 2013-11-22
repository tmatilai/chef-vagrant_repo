#
# Cookbook Name:: vagrant_repo
# Library:: VagrantRepo::Hashfile
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

require 'digest'
require 'pathname'

class VagrantRepo
  # Calculates different hash values from the specified path
  class Hashfile
    attr_reader :path

    def initialize(path)
      @path = path
    end

    def relative_path(base)
      Pathname.new(path).relative_path_from(Pathname.new(base)).to_s
    end

    def size
      File.size(path)
    end

    def md5
      Digest::MD5.file(path).hexdigest
    end

    def sha1
      Digest::SHA1.file(path).hexdigest
    end

    def sha256
      Digest::SHA2.file(path).hexdigest
    end
  end
end

Vagrant Repository Cookbook
===========================

[![Build Status](https://travis-ci.org/tmatilai/chef-vagrant_repo.png?branch=master)][travis]
[![Dependency Status](https://gemnasium.com/tmatilai/chef-vagrant_repo.png)][gemnasium]
[![Code Climate](https://codeclimate.com/github/tmatilai/chef-vagrant_repo.png)][codeclimate]
[![Coverage Status](https://coveralls.io/repos/tmatilai/chef-vagrant_repo/badge.png)][coveralls]

[travis]: https://travis-ci.org/tmatilai/chef-vagrant_repo
[gemnasium]: https://gemnasium.com/tmatilai/chef-vagrant_repo
[codeclimate]: https://codeclimate.com/github/tmatilai/chef-vagrant_repo
[coveralls]: https://coveralls.io/r/tmatilai/chef-vagrant_repo

Chef cookbook for creating and managing package manager repositories for [Vagrant](http://www.vagrantup.com/) packages.

Currently only Apt repository is implemented. It only stores the metadata, and package downloads are redirected to the [official packages](http://downloads.vagrantup.com).

Requirements
------------

Requires [nginx](http://community.opscode.com/cookbooks/nginx) community cookbook.

Recipes
-------

* `default` - Includes all other public recipes.
* `apt` - Sets up Apt repository for Debian packages.

Attributes
----------


License and Author
------------------

Author:: Teemu Matilainen <<teemu.matilainen@iki.fi>>

Copyright © 2013, Teemu Matilainen

Licensed under the Apache License, Version 2.0. See [LICENSE](LICENSE).

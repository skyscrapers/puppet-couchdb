##### LICENSE

# Copyright (c) Skyscrapers (iLibris bvba) 2014 - http://skyscrape.rs
#
# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program.  If not, see <http://www.gnu.org/licenses/>.

# == Class: couchdb
#
# This class is able to install and configure couchdb
#
#
# === Parameters
#
#
# === Examples
#
# * Installation of couchdb
#     class {'couchdb':
#       bind_address    => '127.0.0.1',
#       admin_username  => 'admin',
#       admin_password  => 'secretkey'
#}
#
class couchdb(
  $bind_address       = $couchdb::params::bind_address,
  $default_config     = $couchdb::params::default_config,
  $admin_username     = undef,
  $admin_password     = undef
  ) inherits couchdb::params {

    contain 'couchdb::repo'
    contain 'couchdb::install'
    contain 'couchdb::config'
    contain 'couchdb::service'

    Class['couchdb::repo'] -> Class['couchdb::install'] -> Class['couchdb::config'] ~> Class['couchdb::service']
}

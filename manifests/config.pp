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

# == Class couchdb::config
#
# This class is called from couchdb
#
class couchdb::config {
  if $couchdb::default_config {
    file {
      '/etc/couchdb/local.d/custom.ini':
        ensure => file,
        content => template ('couchdb/etc/couchdb/local.d/custom.ini.erb'),
        mode   => '0644',
        owner  => couchdb,
        group  => couchdb,
        notify => Service['couchdb'];
    }
  }
  if $couchdb::admin_password != undef {
      exec { 'Set admin account':
        command   => "curl -X PUT http://127.0.0.1:5984/_config/admins/${couchdb::admin_username} -d \'\"${couchdb::admin_password}\"\'",
        unless    => "curl -I \'http://127.0.0.1:5984/_config/admins\' | grep 401",
        path      => '/usr/bin/:/bin/',
        logoutput => true,
      }
  }
}

#
# Cookbook Name:: telegraf
# Recipe:: default
#
# Copyright (c) 2016 Byron Schaller, All Rights Reserved.

apt_repository 'influxdata' do
  uri 'https://repos.influxdata.com/ubuntu'
  distribution node[:lsb][:codename]
  components ['stable']
  key 'https://repos.influxdata.com/influxdb.key'
  only_if { platform_family?('debian') }
end

yum_repository 'influxdata' do
  baseurl 'https://repos.influxdata.com/rhel/$releasever/$basearch/stable'
  gpgkey 'https://repos.influxdata.com/influxdb.key'
  only_if { platform_family?('rhel') }
end

package 'telegraf'

service 'telegraf' do
  action [:start, :enable]
end

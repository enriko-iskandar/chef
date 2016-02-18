#
# Cookbook Name:: shinken
# Recipe:: _hosts
#
# Copyright (C) 2014 EverTrue, Inc.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#    http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

active_hosts_list = search(
  :node,
  node['shinken']['host_search_query']
)

if Dir.exist?("#{node['shinken']['conf_dir']}/hosts")
  current_hosts_list = (Dir.entries("#{node['shinken']['conf_dir']}/hosts") -
                        %w(. ..)).map do |e|
                          e.sub(/\.cfg/, '')
                        end

  deleted_hosts_list = current_hosts_list - active_hosts_list.map(&:name)

  deleted_hosts_list.each do |h|
    file "#{node['shinken']['conf_dir']}/hosts/#{h}.cfg" do
      action :delete
      notifies :restart, 'service[shinken-arbiter]'
    end
  end
end

active_hosts_list.each do |n|
  host_conf = {
    'host_name' => n.name,
    'alias' => n.name,
    'address' => n['fqdn']
  }

  template "#{node['shinken']['conf_dir']}/hosts/#{n.name}.cfg" do
    source 'generic-definition.cfg.erb'
    owner  node['shinken']['user']
    group  node['shinken']['group']
    mode   0644
    variables(
      type: 'host',
      conf: host_conf.merge(node['shinken']['host_defaults'])
    )
    notifies :restart, 'service[shinken-arbiter]'
  end
end

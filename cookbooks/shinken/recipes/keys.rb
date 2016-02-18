#
# Cookbook Name:: shinken
# Recipe:: keys
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

directory "#{node['shinken']['home']}/.ssh" do
  owner  node['shinken']['user']
  group  node['shinken']['group']
  mode   0700
  action :create
end

file "#{node['shinken']['home']}/.ssh/id_rsa" do
  owner  node['shinken']['user']
  group  node['shinken']['group']
  mode   0600
  content(
    data_bag_item(
      node['shinken']['agent_key_data_bag'],
      node['shinken']['agent_key_data_bag_item']
    )['shinken']['agent_key']
  )
end

#
# Cookbook Name:: awscli
# Recipe:: default
#

package "python-pip"

execute 'install awscli' do
  command "pip install awscli==#{node[:awscli][:version]}"
  not_if { ::File.exists?("/usr/local/bin/aws") }
end

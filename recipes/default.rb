#
# Cookbook Name:: chef-server-ldap-host
# Recipe:: default
#
# Copyright (c) 2015 Tyler Fitch, All Rights Reserved.

# basically run through examples from https://supermarket.chef.io/cookbooks/windows_ad

include_recipe 'windows_ad'

windows_ad_domain 'chefio.local' do
  action :create
  type 'forest'
  safe_mode_pass 'Passw0rd'
end

windows_ad_domain "chefio.local" do
  action :join
  domain_pass "Passw0rd"
  domain_user "Administrator"
  restart false
end

for i in 1..10 do
  windows_ad_user "Chef #{i}" do
    action :create
    domain_name 'chefio.local'
    ou 'users'
    options ({ 'samid' => "chef#{i}",
               'upn' => "chef#{i}@chefio.local",
               'fn' => 'Chef',
               'ln' => "#{i}",
               'display' => "#{i}, Chef",
               'disabled' => 'no',
               'pwd' => "Passw0rd"
            })
  end
end

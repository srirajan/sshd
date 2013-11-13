#
# Cookbook Name:: sshd
# Recipe:: default
#
# Copyright 2013, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

template "/etc/ssh/sshd_config" do
    source "sshd.erb"
    mode "0644"
    variables(
    :sshd_port => node['sshd']['port'],
    :x11_forwarding => node['sshd']['x11_forwarding'],
    :banner => node['sshd']['banner'],
    :permit_root => node['sshd']['permit_root']
)
end

template "/etc/issue.net" do
    source "issue.net.erb"
end

service "sshd" do
    case node["platform"]
        when "redhat", "centos", "scientific", "fedora", "amazon"
            service_name "sshd"
        when "debian", "ubuntu", "suse"
            service_name "ssh"
    end
    supports :restart => true
    action [ :enable, :restart ]
end

iptables_rule "port_sshd"

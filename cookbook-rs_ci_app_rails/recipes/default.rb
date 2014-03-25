#
# Cookbook Name:: rs_ci_app_rails
# Recipe:: default
#
# Copyright 2014, Ryan J. Geyer <me@ryangeyer.com>
#
# All rights reserved - Do Not Redistribute
#

marker "recipe_start_rightscale" do
  template "rightscale_audit_entry.erb"
end

app_name = "rs_ci_app_rails"
deploy_dir = ::File.join("/opt",app_name)
app_config_file = ::File.join(deploy_dir, "current", "config", "application.rb")
fqdn = "#{node['rs_ci_app_rails']['environment']}-#{node['rs_ci_app_rails']['fqdn']}"

node.normal['nginx']['server_names_hash_bucket_size'] = 128
node.normal['nginx']['install_method'] = 'package'

include_recipe "git" # Required by application cookbook, should it be a pull request there?
include_recipe "runit"
include_recipe "nginx"
include_recipe "route53"

%w{ruby ruby-irb ruby-libs ruby-rdoc rubygems}.each do |p|
  execute "remove #{p} without effecting dependencies" do
    command "rpm -e --nodeps #{p}"
    returns [0,1] # This is ugly, but it's okay if it fails, cause that means the package is already gone.
  end
end

execute "install ruby19" do
  command "yum install -y ruby19*"
end

package "rubygems19"

%w{sqlite-devel}.each do |p|
  package p
end

gem_package "bundler"

application app_name do
  path deploy_dir
  owner "root"
  group "root"
  repository "https://github.com/rgeyer/rs_ci_app_rails"
  revision node['rs_ci_app_rails']['branch']

  rails do
    bundler true
    bundle_command "/opt/rightscale/sandbox/bin/bundle"
    database do
      adapter "sqlite3"
      database "db/production.sqlite3"
    end
  end

  unicorn do
  end
end

template app_config_file do
  source "application.rb.erb"
  variables ({
    :rsemail => node['rs_ci_app_rails']['rs']['email'],
    :rspass => node['rs_ci_app_rails']['rs']['password'],
    :rsaccountid => node['rs_ci_app_rails']['rs']['acct_id']
  })
end

template ::File.join("/etc/nginx/sites-available", app_name) do
  source "nginx_site.conf.erb"
  variables(
      :path => ::File.join(deploy_dir, "current", "public"),
      :app_name => app_name,
      :fqdn => fqdn
  )
end

nginx_site "default" do
  enable false
end

nginx_site app_name

if node['rs_ci_app_rails']['route53']['enabled'] == "true"
  name  = fqdn
  ip    = node['rs_ci_app_rails']['route53']['ip']
  zone  = node['rs_ci_app_rails']['route53']['zone_id']
  log "Updating DNS Record.. Name: #{name} IP: #{ip} Zone: #{zone}"

  # TODO: Validate the node attributes which are now required, but are defined
  # as "optional" in the metadata
  route53_record "create a record" do
    name  name
    value ip
    type  "A"
    ttl   60
    zone_id               zone
    aws_access_key_id     node['rs_ci_app_rails']['route53']['aws_access_key_id']
    aws_secret_access_key node['rs_ci_app_rails']['route53']['aws_secret_access_key']
    overwrite true
    action :create
  end

else
  log "DNS attributes are not set, skipping updating Route53 DNS record."
end

machine_tag "rs_ci_app:lang=rails"
machine_tag "rs_ci_app:environment=#{node['rs_ci_app_rails']['environment']}"
machine_tag "rs_ci_app:branch=#{node['rs_ci_app_rails']['branch']}"
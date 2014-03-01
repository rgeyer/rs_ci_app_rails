#
# Cookbook Name:: rs_ci_app_rails
# Recipe:: default
#
# Copyright 2014, Ryan J. Geyer <me@ryangeyer.com>
#
# All rights reserved - Do Not Redistribute
#

app_name = "rs_ci_app_rails"
deploy_dir = ::File.join("/opt",app_name)

node.normal['nginx']['install_method'] = 'package'

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
  revision "master"

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

template ::File.join("/etc/nginx/sites-available", app_name) do
  source "nginx_site.conf.erb"
  variables(
      :path => ::File.join(deploy_dir, "current", "public"),
      :app_name => app_name,
      :fqdn => node['rs_ci_app_rails']['fqdn']
  )
end

nginx_site "default" do
  enable false
end

nginx_site app_name

if node['rs_ci_app_rails']['route53']['enabled'] == "true"
  log "Updating DNS Record"

  # TODO: Validate the node attributes which are now required, but are defined
  # as "optional" in the metadata
  route53_record "create a record" do
    name  node['rs_ci_app_rails']['route53']['hostname']
    value node['rs_ci_app_rails']['route53']['ip']
    type  "A"
    zone_id               node['rs_ci_app_rails']['route53']['zone_id']
    aws_access_key_id     node['rs_ci_app_rails']['route53']['aws_access_key_id']
    aws_secret_access_key node['rs_ci_app_rails']['route53']['aws_secret_access_key']
    overwrite true
    action :create
  end

else
  log "DNS attributes are not set, skipping updating Route53 DNS record."
end

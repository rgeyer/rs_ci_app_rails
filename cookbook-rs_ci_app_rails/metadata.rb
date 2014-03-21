name             'rs_ci_app_rails'
maintainer       'Ryan J. Geyer'
maintainer_email 'me@ryangeyer.com'
license          'All rights reserved'
description      'Installs/Configures rs_ci_app_rails'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          '0.1.0'

%w{application application_ruby unicorn runit nginx route53 git marker machine_tag}.each do |dep|
  depends dep
end

recipe "rs_ci_app_rails::default", "Sets up the rs_ci_app_rails application"

attribute "rs_ci_app_rails/fqdn",
  :display_name => "FQDN",
  :description => "FQDN for the server, used to configure the server_name for nginx.  Will be prepended by the rs_ci_app_rails/environment.",
  :required => "required",
  :recipes => ["rs_ci_app_rails::default"]

attribute "rs_ci_app_rails/route53/enabled",
  :display_name => "Update Route53 Record?",
  :choice => ["true","false"],
  :required => "optional",
  :recipes => ["rs_ci_app_rails::default"]

attribute "rs_ci_app_rails/route53/ip",
  :display_name => "Route53 IP",
  :default => "env:PUBLIC_IP",
  :required => "optional",
  :recipes => ["rs_ci_app_rails::default"]

attribute "rs_ci_app_rails/route53/zone_id",
  :display_name => "Route53 Zone Id",
  :required => "optional",
  :recipes => ["rs_ci_app_rails::default"]

attribute "rs_ci_app_rails/route53/aws_access_key_id",
  :display_name => "Route53 AWS Access Key Id",
  :required => "optional",
  :recipes => ["rs_ci_app_rails::default"]

attribute "rs_ci_app_rails/route53/aws_secret_access_key",
  :display_name => "Route53 AWS Secret Access Key",
  :required => "optional",
  :recipes => ["rs_ci_app_rails::default"]

attribute "rs_ci_app_rails/environment",
  :display_name => "Environment",
  :description => "The environment name. Usually something like production, dev, test, stage.",
  :required => "optional",
  :default => "production",
  :recipes => ["rs_ci_app_rails::default"]

attribute "rs_ci_app_rails/branch",
  :display_name => "Code Branch",
  :description => "Application code branch or revision.  Passed directly to the git deploy resource",
  :required => "required",
  :recipes => ["rs_ci_app_rails::default"]

attribute "rs_ci_app_rails/rs/email",
  :display_name => "RightScale Account Email",
  :required => "required",
  :recipes => ["rs_ci_app_rails::default"]

attribute "rs_ci_app_rails/rs/password",
  :display_name => "RightScale Account Password",
  :required => "required",
  :recipes => ["rs_ci_app_rails::default"]

attribute "rs_ci_app_rails/rs/acct_id",
  :display_name => "RightScale Account Id",
  :required => "required",
  :recipes => ["rs_ci_app_rails::default"]
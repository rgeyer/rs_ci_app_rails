name             'rs_ci_app_rails'
maintainer       'Ryan J. Geyer'
maintainer_email 'me@ryangeyer.com'
license          'All rights reserved'
description      'Installs/Configures rs_ci_app_rails'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          '0.1.0'

depends "application"
depends "application_ruby"
depends "unicorn"
depends "runit"
depends "nginx"
depends "route53"

recipe "rs_ci_app_rails::default", "Sets up the rs_ci_app_rails application"

attribute "rs_ci_app_rails/fqdn",
  :display_name => "FQDN",
  :description => "FQDN for the server, used to configure the server_name for nginx.",
  :required => "required"

attribute "rs_ci_app_rails/route53/enabled",
  :display_name => "Update Route53 Record?",
  :choice => ["true","false"],
  :required => "optional"

attribute "rs_ci_app_rails/route53/ip",
  :display_name => "Route53 IP",
  :default => "env:PUBLIC_IP",
  :required => "optional"

attribute "rs_ci_app_rails/route53/hostname",
  :display_name => "Route53 Hostname",
  :required => "optional"

attribute "rs_ci_app_rails/route53/zone_id",
  :display_name => "Route53 Zone Id",
  :required => "optional"

attribute "rs_ci_app_rails/route53/aws_access_key_id",
  :display_name => "Route53 AWS Access Key Id",
  :required => "optional"

attribute "rs_ci_app_rails/route53/aws_secret_access_key",
  :display_name => "Route53 AWS Secret Access Key",
  :required => "optional"
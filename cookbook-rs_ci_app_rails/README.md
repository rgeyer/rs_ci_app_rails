rs_ci_app_rails Cookbook
========================
Intended to be used in combination with a RightScale v14 Base ServerTemplate
to stand up an instance of the rs_ci_app_rails[https://github.com/rgeyer/rs_ci_app_rails] application.

There is a pre-assembled RightScale ServerTemplate[https://github.com/rgeyer/rs_ci_app_rails/master/README.rdoc#servertemplate]
to make things easy.

Requirements
------------
Again, all of the requirements are handled if you just use the ServerTemplate[https://github.com/rgeyer/rs_ci_app_rails/master/README.rdoc#servertemplate]

#### Cookbooks
- application
- application_ruby
- unicorn
- runit
- nginx
- route53
- git
- marker
- machine_tag

Attributes
----------
#### rs_ci_app_rails::default
<table>
  <tr>
    <th>Key</th>
    <th>Type</th>
    <th>Description</th>
    <th>Default</th>
  </tr>
  <tr>
    <td><tt>['rs_ci_app_rails']['fqdn']</tt></td>
    <td>String</td>
    <td>FQDN for the server, used to configure the server_name for nginx.  Will be prepended by the rs_ci_app_rails/environment.</td>
    <td>nil</td>
  </tr>
  <tr>
    <td><tt>['rs_ci_app_rails']['route53']['enabled']</tt></td>
    <td>String</td>
    <td>A string (either "true" or "false") as a boolean which indicates if a Route53 DNS record for the FQDN supplied should be updated.</td>
    <td><tt>false</tt></td>
  </tr>
  <tr>
    <td><tt>['rs_ci_app_rails']['route53']['ip']</tt></td>
    <td>String</td>
    <td>The IP address to use when setting the Route53 DNS record.</td>
    <td><tt>env:PUBLIC_IP</tt></td>
  </tr>
  <tr>
    <td><tt>['rs_ci_app_rails']['route53']['zone_id']</tt></td>
    <td>String</td>
    <td>The Route53 zone containing the DNS record which is to be updated.</td>
    <td>nil</td>
  </tr>
  <tr>
    <td><tt>['rs_ci_app_rails']['route53']['aws_access_key_id']</tt></td>
    <td>String</td>
    <td>AWS Access Key ID used to authenticate with the AWS API for Route53.</td>
    <td>nil</td>
  </tr>
  <tr>
    <td><tt>['rs_ci_app_rails']['route53']['aws_secret_access_key']</tt></td>
    <td>String</td>
    <td>AWS Secret Access Key used to authenticate with the AWS API for Route53.</td>
    <td>nil</td>
  </tr>
  <tr>
    <td><tt>['rs_ci_app_rails']['environment']</tt></td>
    <td>String</td>
    <td>A unique environment name for this instance of rs_ci_app_rails.  Prepended to the FQDN</td>
    <td><tt>production</tt></td>
  </tr>
  <tr>
    <td><tt>['rs_ci_app_rails']['branch']</tt></td>
    <td>String</td>
    <td>Application code branch or revision.  Passed directly to the git deploy resource</td>
    <td>nil</td>
  </tr>
  <tr>
    <td><tt>['rs_ci_app_rails']['rs']['email']</tt></td>
    <td>String</td>
    <td>RightScale Account Email used by rs_ci_app_rails to authenticate with the RightScale API</td>
    <td>nil</td>
  </tr>
  <tr>
    <td><tt>['rs_ci_app_rails']['rs']['password']</tt></td>
    <td>String</td>
    <td>RightScale Account Password used by rs_ci_app_rails to authenticate with the RightScale API</td>
    <td>nil</td>
  </tr>
  <tr>
    <td><tt>['rs_ci_app_rails']['rs']['acct_id']</tt></td>
    <td>String</td>
    <td>RightScale Account ID used by rs_ci_app_rails to authenticate with the RightScale API</td>
    <td>nil</td>
  </tr>
</table>

Usage
-----
#### rs_ci_app_rails::default

See the ServerTemplate[https://github.com/rgeyer/rs_ci_app_rails/master/README.rdoc#servertemplate]

License and Authors
-------------------
Authors: Ryan J. Geyer <me@ryangeyer.com>

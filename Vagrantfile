Vagrant.configure("2") do |config|

  config.berkshelf.enabled = true
  #config.omnibus.chef_version = :latest
  config.omnibus.chef_version = "11.6.2"

  config.vm.define :centos do |default_config|
    default_config.vm.hostname = "centos"

    default_config.vm.box = "CentOS 6.3 x86_64 minimal"
    #default_config.vm.box_url = "https://github.com/2creatives/vagrant-centos/releases/download/v0.1.0/centos64-x86_64-20131030.box"

    default_config.vm.network :private_network, ip: "33.33.33.128"

#    default_config.rightscaleshim.run_list_dir = "runlists/centos"
#    default_config.rightscaleshim.shim_dir = "rightscaleshim/centos"
#
#    default_config.vm.provision :shell,
#      inline: <<SCRIPT
#yum install -y wget
#mkdir -p /var/chef/cache
#
#cd /tmp
#wget http://dl.fedoraproject.org/pub/epel/6/x86_64/epel-release-6-8.noarch.rpm
#wget http://rpms.famillecollet.com/enterprise/remi-release-6.rpm
#rpm -Uvh remi-release-6*.rpm epel-release-6*.rpm
#rm -rf remi-release-6*.rpm epel-release-6*.rpm
#
#
## Pre-import the rightscale public key
#rpm --import http://s3.amazonaws.com/rightscale_key_pub/rightscale_key.pub
#
##Create a yum source:
#
#cat > /etc/yum.repos.d/RightLink-staging.repo <<EOF
#[rightlink]
#name=RightLink
#baseurl=http://rightlink-integration.test.rightscale.com/adhoc/ivory/v6.0/yum/1/el/6/x86_64
#gpgcheck=1
#gpgkey=http://s3.amazonaws.com/rightscale_key_pub/rightscale_key.pub
#EOF
#
#yum install -y --nogpgcheck rightlink-cloud-none
#SCRIPT

    default_config.vm.provision :chef_solo do |chef|
      #chef.binary_env = "GEM_HOME=/opt/rightscale/sandbox/lib/ruby/gems/1.9.1"
      #chef.binary_path = "/opt/rightscale/sandbox/bin"

      #chef.json = {
      #    "rightscale" => { "instance_uuid" => "uuid-default" },
      #    "ephemeral_lvm" => {
      #        "filesystem" => "ext4",
      #        "mount_point" => "/mnt/ephemeral",
      #        "logical_volume_name" => "ephemeral0",
      #        "logical_volume_size" => "100%VG",
      #        "stripe_size" => 512,
      #        "volume_group_name" => "vg-data"
      #    },
      #    "rs-base" => {
      #        "collectd_server" => "localhost",
      #        "ntp" => {
      #            "servers" => ["time.rightscale.com","ec2-us-east.time.rightscale.com","ec2-us-west.time.rightscale.com"]
      #        },
      #        "swap" => {
      #            "size" => 1
      #        }
      #    },
      #    "rs_ci_app_rails" => {
      #        "fqdn" => "33.33.33.128",
      #        "route53" => {
      #            "enabled" => "true",
      #            "ip" => "33.33.33.128",
      #            "hostname" => "vagrant-rsciapprails",
      #            "zone_id" => "zone",
      #            "aws_access_key_id" => "key",
      #            "aws_secret_access_key" => "secret"
      #        }
      #    }
      #}

      #chef.run_list = %w(recipe[build-essential] recipe[ephemeral_lvm::default] recipe[rs-machine_tag::default] recipe[rs-base::swap] recipe[rs-base::ntp] recipe[rs-base::rsyslog] recipe[rs-base::collectd] recipe[rs_ci_app_rails])
      chef.run_list = ["recipe[route53]"]
    end
  end
  
end

Vagrant.configure("2") do |config|

  config.berkshelf.enabled = true

  config.vm.define :centos do |default_config|
    default_config.vm.hostname = "centos"

    default_config.vm.box = "CentOS 6.4 x86_64"
    default_config.vm.box_url = "https://github.com/2creatives/vagrant-centos/releases/download/v0.1.0/centos64-x86_64-20131030.box"

    default_config.vm.network :private_network, ip: "33.33.33.128"

    default_config.rightscaleshim.run_list_dir = "runlists/centos"
    default_config.rightscaleshim.shim_dir = "rightscaleshim/centos"

    default_config.vm.provision :shell,
      inline: <<SCRIPT
yum install -y wget
mkdir -p /var/chef/cache

cd /tmp
wget http://dl.fedoraproject.org/pub/epel/6/x86_64/epel-release-6-8.noarch.rpm
wget http://rpms.famillecollet.com/enterprise/remi-release-6.rpm
rpm -Uvh remi-release-6*.rpm epel-release-6*.rpm
rm -rf remi-release-6*.rpm epel-release-6*.rpm


# Pre-import the rightscale public key
rpm --import http://s3.amazonaws.com/rightscale_key_pub/rightscale_key.pub

#Create a yum source:

cat > /etc/yum.repos.d/RightLink-staging.repo <<EOF
[rightlink]
name=RightLink
baseurl=http://rightlink-integration.test.rightscale.com/adhoc/ivory/v6.0/yum/1/el/6/x86_64
gpgcheck=1
gpgkey=http://s3.amazonaws.com/rightscale_key_pub/rightscale_key.pub
EOF

yum install -y --nogpgcheck rightlink-cloud-none
SCRIPT

    default_config.vm.provision :chef_solo do |chef|
      chef.binary_env = "GEM_HOME=/opt/rightscale/sandbox/lib/ruby/gems/1.9.1"
      chef.binary_path = "/opt/rightscale/sandbox/bin"
    end
  end
  
end

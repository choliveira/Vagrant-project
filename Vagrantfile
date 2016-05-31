require_relative 'ServerProvision/provision.rb'

Vagrant.configure(2) do |config|
  config.vm.box = "ubuntu/trusty64"

  config.vm.network "private_network", ip: "192.168.33.22"
  config.vm.synced_folder ".", $provision_config['location'], nfs: true

  config.vm.provider "virtualbox" do |v|
    host = RbConfig::CONFIG['host_os']

    if host =~ /darwin/
      cpus = `sysctl -n hw.ncpu`.to_i

      mem = `sysctl -n hw.memsize`.to_i / 1024 / 1024 / 4
    elsif host =~ /linux/
      cpus = `nproc`.to_i

      mem = `grep 'MemTotal' /proc/meminfo | sed -e 's/MemTotal://' -e 's/ kB//'`.to_i / 1024 / 4
    else # sorry Windows folks, I can't help you
      cpus = 2
      mem = 1024
  end

  v.customize ["modifyvm", :id, "--memory", mem]
  v.customize ["modifyvm", :id, "--cpus", cpus]
end
 config.vm.provision :shell, path: "ServerProvision/bootstrap.sh", args: [$provision_config['mysql_root_password'], $provision_config['php_timezone'], $provision_config['location']]
end

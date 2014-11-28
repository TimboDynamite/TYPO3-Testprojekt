Vagrant.configure("2") do |config|
  config.vm.box = "precise64"
  config.vm.box_url = "http://files.vagrantup.com/precise64.box"
  config.vm.hostname = "typo3.vagrant.vm"
  config.vm.network :forwarded_port, guest: 80, host: 1234
  config.vm.network :forwarded_port, guest: 3306, host: 33060
  config.vm.synced_folder "", "/var/www"
  config.vm.provision :shell, :path => "_vagrant/bootstrap.sh"
end
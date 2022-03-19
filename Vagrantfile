Vagrant.configure("2") do |config|
	
	# https://help.ubuntu.com/community/BIND9ServerHowto
	# See https://www.ip-insider.de/bind9-dns-server-auf-ubuntu-betreiben-a-1020898/
	config.vm.define "dnsserver.vm" do |dnsserver|
		dnsserver.vm.box = "ubuntu/bionic64"
		dnsserver.vm.hostname = "dnsserver.vm"
		dnsserver.vm.network "private_network", ip: "192.168.100.2"
		
		dnsserver.vm.provision "shell", inline: <<-SHELL
			sed -in 's/PasswordAuthentication no/PasswordAuthentication yes/g' /etc/ssh/sshd_config
			systemctl restart sshd.service
		SHELL
		
		dnsserver.vm.provision "shell", path: "scripts/setupdns.sh"

		dnsserver.vm.provider "virtualbox" do |vb|
		  vb.memory = 2048
		  vb.cpus = 2
		end
	  end
  end
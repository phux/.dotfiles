VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
    config.vm.box = "ubuntu/bionic64"

    config.vm.hostname = 'ansible.local'

    config.vm.network "private_network", ip: "10.0.0.10"
    config.vm.provider "virtualbox" do |v|
        v.memory = 4096
        v.cpus = 4
    end
    config.vm.provision :ansible_local do |ansible|
      ansible.playbook = "playbook.yml"
      ansible.limit = 'all,localhost'
      ansible.install_mode = "pip"
    end
end

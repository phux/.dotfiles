VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
    config.vm.box = "ubuntu/trusty64"

    config.hostmanager.enabled = true
    config.hostmanager.manage_host = true
    config.vm.hostname = 'ansible.local'

    config.vm.network "private_network", ip: "10.0.0.10"
    config.vm.provider "virtualbox" do |v|
        v.memory = 2048
        v.cpus = 2
    end
    config.vm.provision :ansible_local do |ansible|
      ansible.playbook = "playbook.yml"
    end
end

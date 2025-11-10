Vagrant.configure("2") do |config|
    config.ssh.insert_key = false

    config.vm.box = "bento/debian-12"

    config.vm.provider "virtualbox" do |v|
        v.memory = 1024
        v.cpus = 1
    end

    config.vm.provision "shell", path: "provision.sh"
end
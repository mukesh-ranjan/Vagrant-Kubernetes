IMAGE_NAME = "ubuntu/bionic64"
N = 2

Vagrant.configure("2") do |config|
    config.ssh.insert_key = false

    # Virtualbox configuration
    config.vm.provider "virtualbox" do |v|
        v.memory = 4096
        v.cpus = 1
    end
      
    # K8s master configuration
    config.vm.define "k8s-master" do |master|
        master.vm.box = IMAGE_NAME
        master.vm.network "private_network", ip: "192.168.50.10"
        master.vm.hostname = "k8s-master"

        # Virtualbox configuration
        master.vm.provider "virtualbox" do |v|
            v.cpus = 2
        end
    end

    # K8s worker configuration
    (1..N).each do |i|
        config.vm.define "k8s-node-#{i}" do |node|
            node.vm.box = IMAGE_NAME
            node.vm.network "private_network", ip: "192.168.50.#{i + 10}"
            node.vm.hostname = "k8s-node-#{i}"
        end
    end

   

end
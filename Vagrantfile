BOX_IMAGE = "debian/buster64"

Vagrant.configure("2") do |config|

        config.vm.define "app" do |subconfig|
            subconfig.vm.box = BOX_IMAGE
            subconfig.vm.network "private_network", ip: "192.168.50.100"
            subconfig.vm.provider "virtualbox" do |vb|
                vb.name = "dtapi_app"
                vb.memory = "1024"
                vb.cpus = "1"
            end
            subconfig.vm.provision :shell, path: "app.sh"
        end

        config.vm.define "db" do |subconfig|
            subconfig.vm.box = BOX_IMAGE
            subconfig.vm.network "private_network", ip: "192.168.50.150"
            subconfig.vm.provider "virtualbox" do |vb|
                vb.name = "dtapi_db"
                vb.memory = "1024"
                vb.cpus = "1"
            end
            subconfig.vm.provision :shell, path: "db.sh"
        end

end

Vagrant.configure("2") do |config|
	config.vm.provision :shell, path: "setup.sh", :privileged => true
	config.vm.hostname = "MosesVM"

	name = "MosesVM"
	memory = 2048

	config.vm.provider "virtualbox" do |virtualbox, override|
		override.vm.box = "bento/ubuntu-16.04"
		virtualbox.memory = memory
	end

	config.vm.provider "libvirt" do |libvirt, override|
		override.vagrant.plugins = ["vagrant-libvirt", "pkg-config"]
		override.vm.box = "generic/ubuntu1604"

		config.vm.synced_folder './', '/vagrant', type: 'rsync'
		#config.vm.synced_folder './', '/vagrant', type: '9p', disabled: false, accessmode: "squash", owner: "1000"

		libvirt.memory = memory
		libvirt.video_type = "none"
		libvirt.graphics_type = "none"
	end
end


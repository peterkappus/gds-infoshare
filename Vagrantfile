# -*- mode: ruby -*-
# vi: set ft=ruby :

# All Vagrant configuration is done below. The "2" in Vagrant.configure
# configures the configuration version (we support older styles for
# backwards compatibility). Please don't change it unless you know what
# you're doing.
Vagrant.configure("2") do |config|
  # The most common configuration options are documented and commented below.
  # For a complete reference, please see the online documentation at
  # https://docs.vagrantup.com.

  # Every Vagrant development environment requires a box. You can search for
  # boxes at https://atlas.hashicorp.com/search.
  config.vm.box = "ubuntu/xenial64"

  # Disable automatic box update checking. If you disable this, then
  # boxes will only be checked for updates when the user runs
  # `vagrant box outdated`. This is not recommended.
  # config.vm.box_check_update = false

  # Create a forwarded port mapping which allows access to a specific port
  # within the machine from a port on the host machine. In the example below,
  # accessing "localhost:8080" will access port 80 on the guest machine.
  # config.vm.network "forwarded_port", guest: 80, host: 8080
  config.vm.network "forwarded_port", guest: 5000, host: 5000
  #config.vm.network :forwarded_port, guest: 3000, host: 3000

  # Create a private network, which allows host-only access to the machine
  # using a specific IP.
  # config.vm.network "private_network", ip: "192.168.33.10"

  # Create a public network, which generally matched to bridged network.
  # Bridged networks make the machine appear as another physical device on
  # your network.
  # config.vm.network "public_network"

  # Share an additional folder to the guest VM. The first argument is
  # the path on the host to the actual folder. The second argument is
  # the path on the guest to mount the folder. And the optional third
  # argument is a set of non-required options.
  # config.vm.synced_folder "../data", "/vagrant_data"

  # Provider-specific configuration so you can fine-tune various
  # backing providers for Vagrant. These expose provider-specific options.
  # Example for VirtualBox:
  #
  # config.vm.provider "virtualbox" do |vb|
  #   # Display the VirtualBox GUI when booting the machine
  #   vb.gui = true
  #
  #   # Customize the amount of memory on the VM:
  #   vb.memory = "1024"
  # end
  #
  # View the documentation for the provider you are using for more
  # information on available options.

  # Define a Vagrant Push strategy for pushing to Atlas. Other push strategies
  # such as FTP and Heroku are also available. See the documentation at
  # https://docs.vagrantup.com/v2/push/atlas.html for more information.
  # config.push.define "atlas" do |push|
  #   push.app = "YOUR_ATLAS_USERNAME/YOUR_APPLICATION_NAME"
  # end

  # Enable provisioning with a shell script. Additional provisioners such as
  # Puppet, Chef, Ansible, Salt, and Docker are also available. Please see the
  # documentation for more information about their specific syntax and use.
  # config.vm.provision "shell", inline: <<-SHELL
  #   apt-get update
  #   apt-get install -y apache2
  # SHELL
   config.vm.provision "shell", inline: <<-SHELL
    sudo apt-get update
    sudo apt-get install -y git-core curl zlib1g-dev build-essential libssl-dev libreadline-dev libyaml-dev libsqlite3-dev sqlite3 libxml2-dev libxslt1-dev libcurl4-openssl-dev python-software-properties libffi-dev nodejs

    git clone https://github.com/rbenv/rbenv.git ~/.rbenv
    echo 'export PATH="/home/ubuntu/.rbenv/bin:$PATH"' >> ~/.bashrc
    echo 'eval "$(rbenv init -)"' >> ~/.bashrc

    # use in this session
    export PATH="/home/ubuntu/.rbenv/bin:$PATH"

    git clone https://github.com/rbenv/ruby-build.git ~/.rbenv/plugins/ruby-build
    echo 'export PATH="/home/ubuntu/.rbenv/plugins/ruby-build/bin:$PATH"' >> ~/.bashrc

    #use in this session
    export PATH="/home/ubuntu/.rbenv/plugins/ruby-build/bin:$PATH"

    rbenv install 2.3.3
    rbenv global 2.3.3
    #ruby -v

    gem install bundler

    curl -sL https://deb.nodesource.com/setup_4.x | sudo -E bash -
    sudo apt-get install -y nodejs

    gem install rails -v 5.0.0.1
    rbenv rehash

    #POSTGRES
    sudo sh -c "echo 'deb http://apt.postgresql.org/pub/repos/apt/ xenial-pgdg main' > /etc/apt/sources.list.d/pgdg.list"
    wget --quiet -O - http://apt.postgresql.org/pub/repos/apt/ACCC4CF8.asc | sudo apt-key add -
    sudo apt-get update
    sudo apt-get install -y postgresql-common
    sudo apt-get install -y postgresql-9.5 libpq-dev

    #Install a matching client.
    sudo apt-get install -y postgresql-client-9.5

    #Create a new super user
    sudo -u postgres createuser ubuntu -s

    #Install heroku toolbelt
    sudo add-apt-repository "deb https://cli-assets.heroku.com/branches/stable/apt ./"
    curl -L https://cli-assets.heroku.com/apt/release.key | sudo apt-key add -
    sudo apt-get update
    sudo apt-get install -y heroku

    echo "install PhantomJS"
    #grab it
    #curl -O https://phantomjs.googlecode.com/files/phantomjs-1.9.2-linux-i686.tar.bz2
    curl -OL https://bitbucket.org/ariya/phantomjs/downloads/phantomjs-2.1.1-linux-x86_64.tar.bz2

    #unzip
    bunzip2 phantomjs-2.1.1-linux-x86_64.tar.bz2
    #untar
    tar -xf phantomjs-2.1.1-linux-x86_64.tar
    #add it to our path
    echo 'export PATH="$HOME/phantomjs-2.1.1-linux-x86_64/bin:$PATH"' >> ~/.bashrc
    export PATH="$HOME/phantomjs-2.1.1-linux-x86_64/bin:$PATH" #for use in this session


    #NOTE: You'll need to update your config/database.yml
    # to use the "ubuntu" user for the default config:
    #
    #username: ubuntu

    #NOTE: To start the server:
    # cd /vagrant/myapp
    # bundle
    # rails s -b0.0.0.0

    #NOTE: Add the following to allow your host machine to videw the web console in development:
    #
    #config/environments/development.rb
    #
    #class Application < Rails::Application
    #  config.web_console.whitelisted_ips = '10.0.2.2'
    #end


   SHELL
end

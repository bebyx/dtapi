# Training deploy scripts

[Vagrant](https://www.vagrantup.com/)-empowered script to deploy dtapi app ([backend](https://github.com/yurkovskiy/dtapi) and [frontend](https://github.com/yurkovskiy/IF-105.UI.dtapi.if.ua.io)) connected to database server on a separate VM.

## Environment details

**Technologies:** PHP Ko7, Angular, MySQL (MariaDB), Apache

**Host machine OS:** Debian GNU/Linux bullseye/sid x86_64 — SMP Debian 5.7.6-1 (2020-06-24)

**Host machine Kernel:** 5.7.0-1-amd64

**VirtualBox:** Version 6.1.12 r139181 (Qt5.6.1)

<details>
  <summary>How to Install VirtualBox on Debian Bullseye/sid</summary>

  https://www.youtube.com/watch?v=9KJ7B-mYKYA
</details>

**Vagrant box image:** [debian/buster64](https://app.vagrantup.com/debian/boxes/buster64) (virtualbox, 10.4.0)

## Host machine dependencies

You obviously will need Vagrant installed on your host machine. The recommended way is to install [the latest version](https://www.vagrantup.com/downloads) locally. (Indeed, the one from official Bullseye repository just breaks).

`dpkg -i ./vagrant*.deb`

Also, make sure to install `rsync` on your host machine to enable `/vagrant/` shared folder.

`sudo apt install rsync`

## Deploy

Clone the repo:

`git clone https://github.com/bebyx/dtapi.git`

Go to the cloned directory:

`cd dtapi/`

Start Vagrant script:

`vagrant up`

Wait while the script finishes its work...

Visit running app in your host machine browser: http://192.168.50.100

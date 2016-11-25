# Nova Snap

This repository contains the source code of the snap for the OpenStack Compute
service, Nova.

This snap specifically provides the compute controller daemons as part of a
snap based OpenStack deployment.

## Installing this snap

The nova snap can be installed directly from the snap store:

    sudo snap install [--edge] nova

## Configuring Nova

Snaps run in an AppArmor and seccomp confined profile, so don't read
configuration from `/etc/nova` on the hosting operating system install.

This snap supports configuration via the $SNAP\_COMMON writable area for the
snap:

    etc
    ├── nova
    │   ├── nova.conf
    └── nova.conf.d
        ├── database.conf
        ├── nova-snap.conf
        └── keystone.conf

The nova snap can be configured in a few ways.

Firstly the nova-server daemon will detect and read `etc/nova/nova.conf`
if it exists so you can reuse your existing tooling to write to this file
for classic style configuration.

Alternatively the nova  daemons will load all configuration files from
`etc/nova.conf.d` - in the above example, database and keystone authtoken
are configured  using configuration snippets in separate files in
`etc/nova.conf.d`.

For reference, $SNAP\_COMMON is typically located under
`/var/snap/nova/common`.

## Managing Nova

Currently all snap binaries must be run as root; for example, to run the
nova-manage binary use:

    sudo nova.manage

## Restarting Nova services

To restart all nova services:

    sudo systemctl restart snap.nova.*

or restart services individually:

    sudo systemctl restart snap.nova.api

## Building the Nova snap

Simply clone this repository and then install and run snapcraft:

    git clone https://github.com/openstack-snaps/snap-nova
    sudo apt install snapcraft
    cd nova
    snapcraft

## Support

Please report any bugs related to this snap on
[Launchpad](https://bugs.launchpad.net/snap-nova/+filebug).

Alternatively you can find the OpenStack Snap team in `#openstack-snaps`
on Freenode IRC.

# Nova Snap

This repository contains the source code of the snap for the OpenStack Compute
service, Nova.

This snap specifically provides the compute controller daemons as part of a
snap based OpenStack deployment.

## Installing this snap

The nova snap can be installed directly from the snap store:

    sudo snap install --edge nova

The nova snap is working towards publication across tracks for
OpenStack releases. The edge channel for each track will contain the tip
of the OpenStack project's master or stable branch, with the beta, candidate,
and stable channels being reserved for released versions. The same version
will be published progressively to beta, then candidate, and then stable once
CI validation completes for the channel. This should result in an experience
such as:

    sudo snap install --channel=ocata/stable nova
    sudo snap install --channel=pike/edge nova

## Configuring nova

The nova snap gets its default configuration from the following $SNAP
and $SNAP_COMMON locations:

    /snap/nova/current/etc/
    └── nova
        ├── nova.conf
        └── ...

    /var/snap/nova/common/etc/
    ├── nova
    │   └── nova.conf.d
    │       └── nova-snap.conf
    ├── nginx
    │   ├── snap
    │   │   ├── nginx.conf
    │   │   └── sites-enabled
    │   │       └── nova.conf
    └── uwsgi
        └── snap
            └── nova-placement-api.ini

The nova snap supports configuration updates via its $SNAP_COMMON writable
area. The default nova configuration can be overridden as follows:

    /var/snap/nova/common/etc/
    ├── nova
    │   ├── nova.conf.d
    │   │   ├── nova-snap.conf
    │   │   ├── database.conf
    │   │   └── rabbitmq.conf
    │   └── nova.conf
    ├── nginx
    │   ├── snap
    │   │   ├── nginx.conf
    │   │   └── sites-enabled
    │   │       └── nova.conf
    │   ├── nginx.conf
    │   ├── sites-enabled
    │   │   └── nova.conf
    └── uwsgi
        ├── snap
        │   └── nova-placement-api.ini
        └── nova-placement-api.ini

The nova configuration can be overridden or augmented by writing
configuration snippets to files in the nova.conf.d directory.

Alternatively, nova configuration can be overridden by adding a full nova.conf
file to the nova/ directory. If overriding in this way, you'll need to update
your config to point at additional config files located in $SNAP, or add those
to $SNAP_COMMON as well.

The nova nginx configuration can be overridden by adding an nginx/nginx.conf
and new site config files to the nginx/sites-enabled directory. In this case the
nginx/nginx.conf file would include that sites-enabled directory. If
nginx/nginx.conf exists, nginx/snap/nginx.conf will no longer be used.

The nova uwsgi configuration can be overridden similarly by adding a
uwsgi/nova-placement-api.ini file. If uwsgi/nova-placement-api.ini exists,
uwsgi/snap/nova-placement-api.ini will no longer be used.

## Logging nova

The services for the nova snap will log to its $SNAP_COMMON writable area:
/var/snap/nova/common/log.

## Managing nova

The nova snap has alias support that enables use of the well-known
nova-manage command. To enable the alias, run the following prior to
using the command:

    sudo snap alias nova.manage nova-manage

## Restarting nova services

To restart all nova services:

    sudo systemctl restart snap.nova.*

or an individual service can be restarted by dropping the wildcard and
specifying the full service name.

## Building the nova snap

Simply clone this repository and then install and run snapcraft:

    git clone https://github.com/openstack/snap-nova
    sudo apt install snapcraft
    cd snap-nova
    snapcraft

## Support

Please report any bugs related to this snap at:
[Launchpad](https://bugs.launchpad.net/snap-nova/+filebug).

Alternatively you can find the OpenStack Snap team in `#openstack-snaps` on
Freenode IRC.

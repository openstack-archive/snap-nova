#!/bin/bash

set -ex

source $BASE_DIR/admin-openrc

snap list | grep -q "^nova\s" || {
    sudo snap install --edge nova
}

openstack user show nova || {
    openstack user create --domain default --password nova nova
    openstack role add --project service --user nova admin
}

openstack user show placement || {
    openstack user create --domain default --password placement placement
    openstack role add --project service --user placement admin
}

openstack service show compute || {
    openstack service create --name nova \
      --description "OpenStack Compute" compute

    for endpoint in public internal admin; do
        openstack endpoint create --region RegionOne \
          compute $endpoint http://localhost:8774/v2.1/%\(tenant_id\)s || :
    done
}

openstack service show placement || {
    openstack service create --name placement \
      --description "Placement API" placement

    for endpoint in public internal admin; do
        openstack endpoint create --region RegionOne \
          placement $endpoint http://localhost:8778 || :
    done
}


while sudo [ ! -d /var/snap/nova/common/etc/nova/ ]; do sleep 0.1; done;
sudo cp -r $BASE_DIR/etc/snap-nova/* /var/snap/nova/common/etc/

# Manually define alias if snap isn't installed from snap store.
# Otherwise, snap store defines this alias automatically.
snap aliases nova | grep nova-manage || sudo snap alias nova.manage nova-manage

sudo nova-manage api_db sync
sudo nova-manage cell_v2 list_cells | grep cell0 || sudo nova-manage cell_v2 map_cell0
sudo nova-manage cell_v2 list_cells | grep cell1 || sudo nova-manage cell_v2 create_cell --name=cell1 --verbose
sudo nova-manage db sync

sudo systemctl restart snap.nova.*

while ! nc -z localhost 8774; do sleep 0.1; done;

sleep 5

openstack flavor show m1.tiny || openstack flavor create --id 1 --ram 512 --disk 1 --vcpus 1 m1.tiny
openstack flavor show m1.small || openstack flavor create --id 2 --ram 2048 --disk 20 --vcpus 1 m1.small
openstack flavor show m1.medium || openstack flavor create --id 3 --ram 4096 --disk 20 --vcpus 2 m1.medium
openstack flavor show m1.large || openstack flavor create --id 4 --ram 8192 --disk 20 --vcpus 4 m1.large
openstack flavor show m1.xlarge || openstack flavor create --id 5 --ram 16384 --disk 20 --vcpus 8 m1.xlarge

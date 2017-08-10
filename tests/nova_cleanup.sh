#!/bin/bash

set -x

sudo mysql -u root << EOF
DROP DATABASE nova;
DROP DATABASE nova_api;
DROP DATABASE nova_cell0;
EOF

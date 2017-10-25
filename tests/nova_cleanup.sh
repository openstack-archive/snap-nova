#!/bin/bash

set -x

sudo mysql -u root << EOF
DROP DATABASE IF EXISTS nova;
DROP DATABASE IF EXISTS nova_api;
DROP DATABASE IF EXISTS nova_cell0;
EOF

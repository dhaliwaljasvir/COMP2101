#!/bin/bash

#Creating (F) Variable to store information of free disk file on rootfilesystem
F=$(df -h / |grep Avail -v |awk '{print $4}')

#Creating (M) Variable to store info of version and operating system name
M=$(cat /etc/issue|awk '{print ($1,$2, $3)}'|awk '!/^[[:space:]]*$/')


cat << EOF
Report for myvm
===============
FQDN: $(hostname -f)
Operating System name and version: $M
IP Address: $(hostname -I)
Root Filesystem Free Space: $F
===============
EOF


#!/bin/bash

cat <<EOF
FQDN: $(hostname)
Host Information:
 $(hostnamectl)
IP Address:
$(hostname -I)
root Filesystem Status:
$(df -h /)

EOF



#!/bin/bash
#this is lab3 Virtual Web Server creation in Ubuntu  
# **********Root Priveleges ******* is required to run script without any errors
# First step is to install lxd and test for it
command -v lxd > /dev/null
if [ $? -eq 0 ];then
    echo "great!you already have lxd installed "
else
    echo "you donot have lxd installed so lets install it"
    sudo snap install lxd
fi

# Second step is to check status of interface lxdbr0
if ip a s lxdbr0 | grep lxdbr0 >/dev/null; then
   echo "interface lxdbr0 is confirmed"
else
   lxd init --auto
   echo "lxdbr0 is created "
fi

# Third step is to check container presence if its not then creating and launching a new one
lxc list | grep COMP2101-S22 >/dev/null
if [ $? -ne 0 ];then
   echo "launching a new conatiner"
   lxc launch ubuntu:22.04 COMP2101-S22
else
   echo "existing conatiner is launched"
fi

#Fourth step is to check hosts file for ip of new container and update it if ip doesnot exist
if grep COMP2101-S22 /etc/hosts > /dev/null; then
     echo "hosts file  already conatin IP of new conatiner"
else
   sudo sh -c "lxc list COMP2101-S22 | awk '{print \$6, \$2}' >> /etc/hosts"
   echo "hosts file is getting updated with IP "
fi
sudo sh -c "lxc list COMP2101-S22 | awk '{print \$6, \$2}' >> /etc/hosts"
sudo sh -c "lxc list COMP2101-S22 | awk '{print \$6, \$2}' >> /etc/hosts"

#Fifth step is to install Apache2 in container
lxc exec COMP2101-S22 service apache2 status > /dev/null
if [ $? -eq 0 ]; then
   echo "Server(Apache2) is already present "
else
   echo "installing apache2 inside container"
   lxc exec COMP2101-S22 -- apt update
   lxc exec COMP2101-S22 -- apt  install -y apache2
fi

#Sixth step is to retrieve webpage using curl command
sudo apt install curl
curl http://COMP2101-S22 >/dev/null
if [ $? -eq 0 ];then
   echo "Welcome :) you are connected"
else
   echo "your connection remained unsuccessfull"
fi


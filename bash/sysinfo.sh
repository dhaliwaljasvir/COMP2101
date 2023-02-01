#!/bin/bash

#this is scipt to provide system information

#this command is to  provide information related to hostname
echo "FQDN : `hostname`"
#this command is used to provide information about host details
echo "Host Information :"
echo "$(hostnamectl):"
#this will provide ip other than loop address
echo  "IP Addresses :"`hostname -I`
#this command is used to provide space available on filesystem
echo  "Root Filesystem Status :"
echo  "`df -h /`"

#!/bin/bash

PC_IP="$1"

echo "Creating cron job for capacity"

( crontab -l ; echo '@hourly /usr/bin/timeout 1h bash -lc "cd /home/nutanix/lab/capacity_data/;python capacity_prismpro_write.py" > /tmp/debug.log' ) | crontab -

crontab -l

cd capacity_data

echo 'Writing VMBL Data'
# Write VBML data to IDF
python xfit_prismpro_write.py

cd ../

# Register the PE
python create_zeus_entity.py $PC_IP 00057d50-00df-b390-0000-00000000eafd Prism-Pro-Cluster
# Try again for good luck
python create_zeus_entity.py $PC_IP 00057d50-00df-b390-0000-00000000eafd Prism-Pro-Cluster
# Try again for good luck
python create_zeus_entity.py $PC_IP 00057d50-00df-b390-0000-00000000eafd Prism-Pro-Cluster
# Try again for good luck [4th time is the charm! ;)]
python create_zeus_entity.py $PC_IP 00057d50-00df-b390-0000-00000000eafd Prism-Pro-Cluster
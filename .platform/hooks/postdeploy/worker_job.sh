#!/bin/sh
      if [ ! -d "/mnt/efs" ]; then
        EFS_VAR=$(/opt/elasticbeanstalk/bin/get-config environment -k EFS_MOUNT)
        EFS_IP=$(/opt/elasticbeanstalk/bin/get-config environment -k EFS_MOUNT_IP)
        echo "${EFS_IP} ${EFS_VAR}.efs.us-east-2.amazonaws.com" | sudo tee -a /etc/hosts
        sudo mkdir /mnt/efs
        sudo mount -t nfs4 -o nfsvers=4.1,rsize=1048576,wsize=1048576,hard,timeo=600,retrans=2,noresvport ${EFS_VAR}.efs.us-east-2.amazonaws.com:/ /mnt/efs
        sudo chown -R webapp:webapp /mnt/efs
        echo "EFS created"
      fi
      if [ ! -L "/var/www/html/wp-content/uploads" ]; then
        echo "Creating symlink"
        sudo ln -sf /mnt/efs /var/app/current/wp-content/uploads
        echo "symlink created"
      fi


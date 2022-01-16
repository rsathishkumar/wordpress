#!/bin/sh
      if [ ! -d "/mnt/efs" ]; then
        sudo mkdir /mnt/efs
        sudo mount -t nfs4 -o nfsvers=4.1,rsize=1048576,wsize=1048576,hard,timeo=600,retrans=2,noresvport fs-0c865950986d6f971.efs.us-east-2.amazonaws.com:/ /mnt/efs
        sudo chown -R webapp:webapp /mnt/efs
        echo "EFS created"
      fi
      if [ ! -L "/var/www/html/wp-content/uploads" ]; then
        echo "Creating symlink"
        sudo ln -sf /mnt/efs /var/app/current/wp-content/uploads
        echo "symlink created"
      fi



# add SSH public key for rroth
mkdir .ssh
echo "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQDJlX6wXYeHklqGOVitddFXRnmHDqrq8kaSvTo11xBR4r0LA99oiWBO/3Ge8Fx4yfGHu+h5mmU0Rnd1qTmCs69f+0IbvVSCwnXp+noW4SUrAMW9TYLg1zYhy10ePl+iZgl5FbEK7pvm1/rVa/pOE44KiDxg7FxyoMzoFcB/Z0044xo4WRS5YKFkAyLN2zM9zWRGS+MwfgjOUy4V5/0RRq+f/Yu+us7C365RS7TbhrCVcnNOfCKbnta194eq+KnwSENyexqg8q1QjySpg1djYzmBE4H7gsUD0etZ343T4PIFuWkUmJg16bWeGpwRK3Sgk0UBo9F199Nx1H7djC7A5YfcHb62cn63l2FGF35mItEa4qJgL+qS1QG+caVo6SuDdV/5Hklpjsu3Be90e7xYBr/InUp1mwWs8r7q+EKglDCW9SqsMYh/TDfWk3v6Fl/qu1EQlBoUj1/zfHcCs/CDYSXqejQ9wg6HnumRBSVwjjrAwby5CRYbWUT9KKb6r6xkAgufC20rnmkW1XduhgIeo5hn9bDwakYJtcXDZUm0mbPtCYyMJka4Xp9oxXnl7lpbRwr2R3KDwhG4LIFWl0UV6wOpezDxA8i8SquiG0y//mCDS2MnZzJlDNg2fKVB2u7s/xSXO+dwEPUw3D4n/F+ILerEmEGxoPVMjzrWi+km6RVJRQ== 53:f3:a9:f8:8e:21:cd:64:50:f0:cb:aa:4f:ea:0f:50 rroth@bgs.ac.uk" >> ~/.ssh/authorized_keys
sudo chmod 600 ~/.ssh/authorized_keys

sudo chmod 700 ~/.ssh



# install the official postgres repository
sudo yum -y install https://download.postgresql.org/pub/repos/yum/reporpms/EL-7-x86_64/pgdg-redhat-repo-latest.noarch.rpm

# install postgres 9.5, the same version as used at the NMA in Sierra Leone
sudo yum -y install postgresql12
sudo yum -y install postgresql12-server
sudo /usr/pgsql-12/bin/postgresql-12-setup initdb
# start postgres automatically on a system reboot
sudo systemctl enable postgresql-12
sudo systemctl start postgresql-12


#find the directory where postgres stores the pg_hba.conf and postgresql.conf configuration files
cd /
pghbafilelocation=`sudo -u postgres psql --username=postgres --dbname=postgres --command="SHOW hba_file;" | grep \/ | xargs`
echo $pghbafilelocation
pgconfigfilelocation=`sudo -u postgres psql --username=postgres --dbname=postgres --command="SHOW config_file;" | grep \/ | xargs`
echo $pgconfigfilelocation

# Allow connections from places other than the machine that the database is installed on, using a password.
sudo sed -i "s/#listen_addresses = 'localhost'/listen_addresses = '*'        /" $pgconfigfilelocation 
sudo cat $pgconfigfilelocation | grep listen_ 

# Allow password authentication from any incoming IPv4 connection
echo "
# this was added by RROTH for the BMGF MAPS project 
host     all             all            0.0.0.0/0                md5
" | sudo -u postgres tee --append $pghbafilelocation

# Do not use 'ident' authentication method; use password authentication instead
sudo sed -i 's/ident/md5/' $pghbafilelocation
#sudo cat $pghbafilelocation


# Restart the postgres service
sudo service postgresql-12 restart



sudo -u postgres psql --username=postgres --dbname=postgres --command="CREATE USER rroth WITH LOGIN;" 
sudo -u postgres psql --username=postgres --dbname=postgres --command="ALTER USER rroth WITH SUPERUSER;" 
sudo -u postgres psql --username=postgres --dbname=postgres --command="CREATE DATABASE rroth;" 


sudo -u postgres psql --username=postgres --dbname=postgres



# open up the firewall (if necessary)
systemctl stop firewalld


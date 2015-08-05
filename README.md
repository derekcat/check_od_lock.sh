# check_od_lock.sh

Nagios plugin to check if you have a disabled user in Open Directory


Install the plugin into your NRPE client's /usr/local/nagios/libexec/ folder

Edit /etc/nrpe.cfg and add the line:

command[check_od_lock]=/usr/local/nagios/libexec/check_od_lock.sh


Then add a service on your Nagios server, using the command:

$USER1$/check_nrpe -H $HOSTNAME$ -c check_od_lock


Enjoy!
-Derekcat

#!/bin/bash
# Script written by Derek DeMoss (github.com/derekcat) for Dark Horse Comics, Inc. 2015
# Intended to be run by NRPE for a Nagios check

# Make a list of OpenDirectory Users
ODUSERS="$(dscl /LDAPv3/127.0.0.1 -list /Users | grep -v vpn | grep -v ldap)"
# Cleanly initialize our list of disabled users
DISABLEDUSERS=""

for user in $ODUSERS # Step through our list of users
do
	# If they're disabled, then add them to the list
	YESDISABLED="$(pwpolicy -u $user -getpolicy | awk '{print $1}' | grep isDisabled=1)"
	if [ $YESDISABLED ]
	then
		DISABLEDUSERS+="$user "
	fi
done

if [[ -n "$DISABLEDUSERS" ]] #if $DISABLEDUSERS is not empty, print them
then
	echo "SERVICE STATUS: Critical"
	echo "Disabled user[s]:$DISABLEDUSERS"
	exit 2
else
	echo "SERVICE STATUS: OK"
	exit 0
fi

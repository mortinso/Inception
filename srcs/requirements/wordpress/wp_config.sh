#!/bin/bash

if [ ! -f wp-config.php ]
then

else
	echo "Wordpress is already installed and set up."
fi

exec $@
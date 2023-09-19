#!/bin/bash
# get info from periodic table 
PSQL="psql -X --username=freecodecamp --dbname=periodic_table -t --no-align -c"
if [[ -z $1 ]]
then
	echo "Please provide an element as an argument."
elif [[ $1 =~ ^[0-9]+$ ]] 
then
	echo "number"
	#if not in table
		# exit
	#else print info
else
	echo "else"
	#get atomic weight
	#if not exist
		# exit
	#else print info
fi

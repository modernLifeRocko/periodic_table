#!/bin/bash
# get info from periodic table 
PSQL="psql -X --username=freecodecamp --dbname=periodic_table -t --no-align -c"
PRINT_FROM_NUMBER () {
	echo "$($PSQL "SELECT name, symbol, atomic_mass, melting_point_celsius, boiling_point_celsius, type FROM elements
	INNER JOIN properties USING(atomic_number) LEFT JOIN types USING(type_id) WHERE atomic_number=$1")" | while IFS='|' read NAME SYMBOL ATOMIC_MASS MELTING_POINT BOILING_POINT TYPE
	do
	if [[ -z $NAME ]]
	then
		echo "I could not find that element in the database."
	else
		echo "The element with atomic number $1 is '$NAME' ($SYMBOL). It's a '$TYPE', with a mass of $ATOMIC_MASS amu. '$NAME' has a melting point of of $MELTING_POINT celsius and a boiling point of $BOILING POINT celsius."
	fi
	done
}
if [[ -z $1 ]]
then
	echo "Please provide an element as an argument."
elif [[ $1 =~ ^[0-9]+$ ]] 
then
	PRINT_FROM_NUMBER $1
else
	echo "else"
	#get atomic weight
	#if not exist
		# exit
	#else print info
fi

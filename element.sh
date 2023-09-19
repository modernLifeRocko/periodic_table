#!/bin/bash
# Program to get information on elements from the periodic table 
PSQL="psql -X --username=freecodecamp --dbname=periodic_table -t --no-align -c"
PRINT_FROM_NUMBER () {
	echo "$($PSQL "SELECT name, symbol, atomic_mass, melting_point_celsius, boiling_point_celsius, type FROM elements
	INNER JOIN properties USING(atomic_number) LEFT JOIN types USING(type_id) WHERE atomic_number=$1")" | while IFS='|' read NAME SYMBOL ATOMIC_MASS MELTING_POINT BOILING_POINT TYPE
	do
	if [[ -z $NAME ]]
	then
		echo "I could not find that element in the database."
	else
		echo "The element with atomic number $1 is $NAME ($SYMBOL). It's a $TYPE, with a mass of $ATOMIC_MASS amu. $NAME has a melting point of $MELTING_POINT celsius and a boiling point of $BOILING_POINT celsius."
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
	#get atomic weight
	ATOMIC_NUMBER=$($PSQL "SELECT atomic_number FROM elements WHERE symbol='$1' OR name='$1'")
	#if not exist
	if [[ -z $ATOMIC_NUMBER ]]
	then
		echo "I could not find that element in the database."
	else
		PRINT_FROM_NUMBER $ATOMIC_NUMBER
	fi
fi

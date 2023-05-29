#!/bin/bash
PSQL="psql -X --username=freecodecamp --dbname=periodic_table --tuples-only -c"
if [[ -z $1 ]]
then
echo "Please provide an element as an argument."
elif [[ $1 == 1 || $1 == 'H' || $1 == 'Hydrogen' ]]
then
echo "The element with atomic number 1 is Hydrogen (H). It's a nonmetal, with a mass of 1.008 amu. Hydrogen has a melting point of -259.1 celsius and a boiling point of -252.9 celsius."
elif  ! [[ $1 =~ ^[0-9]+$ ]]
then
#check lenght of variable
len=`expr "$1" : '.*'`
if [[ (len -eq 1) || (len -eq 2) ]]
then
#echo "1"
RES=$($PSQL "SELECT atomic_number,name,symbol,type,atomic_mass,melting_point_celsius,boiling_point_celsius FROM properties INNER JOIN elements USING(atomic_number) INNER JOIN types USING(type_id) WHERE elements.symbol = '$1'")
if [[ -z $RES ]]
then
echo "I could not find that element in the database."
else
echo "$RES" | while read ATOMIC_NUMBER BAR NAME BAR SYMBOL BAR TYPE BAR ATOMIC_MASS BAR MELTING_POINT_CELSIUS BAR BOILING_POINT_CELSIUS
  do
    echo "The element with atomic number" $ATOMIC_NUMBER "is" $NAME "("$SYMBOL"). It's a" $TYPE", with a mass of" $ATOMIC_MASS "amu." $NAME "has a melting point of" $MELTING_POINT_CELSIUS "celsius and a boiling point of" $BOILING_POINT_CELSIUS "celsius."
  done
fi
else
#echo "2"
RES=$($PSQL "SELECT atomic_number,name,symbol,type,atomic_mass,melting_point_celsius,boiling_point_celsius FROM properties INNER JOIN elements USING(atomic_number) INNER JOIN types USING(type_id) WHERE elements.name = '$1'")
if [[ -z $RES ]]
then
echo "I could not find that element in the database."
else
echo "$RES" | while read ATOMIC_NUMBER BAR NAME BAR SYMBOL BAR TYPE BAR ATOMIC_MASS BAR MELTING_POINT_CELSIUS BAR BOILING_POINT_CELSIUS
  do
    echo "The element with atomic number" $ATOMIC_NUMBER "is" $NAME "("$SYMBOL"). It's a" $TYPE", with a mass of" $ATOMIC_MASS "amu." $NAME "has a melting point of" $MELTING_POINT_CELSIUS "celsius and a boiling point of" $BOILING_POINT_CELSIUS "celsius."
  done
fi
fi
#check lenght of variable
else
RES=$($PSQL "SELECT atomic_number,name,symbol,type,atomic_mass,melting_point_celsius,boiling_point_celsius FROM properties INNER JOIN elements USING(atomic_number) INNER JOIN types USING(type_id) WHERE properties.atomic_number = $1")
if [[ -z $RES ]]
then
echo "I could not find that element in the database."
else
echo "$RES" | while read ATOMIC_NUMBER BAR NAME BAR SYMBOL BAR TYPE BAR ATOMIC_MASS BAR MELTING_POINT_CELSIUS BAR BOILING_POINT_CELSIUS
  do
    echo "The element with atomic number" $ATOMIC_NUMBER "is" $NAME "("$SYMBOL"). It's a" $TYPE", with a mass of" $ATOMIC_MASS "amu." $NAME "has a melting point of" $MELTING_POINT_CELSIUS "celsius and a boiling point of" $BOILING_POINT_CELSIUS "celsius."
  done
fi
fi
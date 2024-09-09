PSQL="psql -X --username=freecodecamp --dbname=periodic_table --tuples-only -c"
if [[ $1 ]]
then
  #Get element details
  #Check if the input is a number
  if [[ $1 =~ ^[0-9]+$ ]]
  #get element atomic number, symbol and name
  then
    read NUMBER SYMBOL NAME <<< $(echo "$($PSQL "SELECT * FROM elements WHERE atomic_number = $1;")" | sed 's/ *//g; s/|/ /g')
  else
    read NUMBER SYMBOL NAME <<< $(echo "$($PSQL "SELECT * FROM elements WHERE symbol = '$1' OR name = '$1';")" | sed 's/ *//g; s/|/ /g')
  fi
  #Check if the element exists in the database
  if [[ $NUMBER ]]
  then
    #Get element details
    read TYPE MASS MELT_POINT BOIL_POINT <<< $(echo "$($PSQL "SELECT type, atomic_mass, melting_point_celsius, boiling_point_celsius FROM properties LEFT JOIN types USING(type_id) WHERE atomic_number = $NUMBER;")" | sed 's/ *//g; s/|/ /g')
    echo "The element with atomic number $NUMBER is $NAME ($SYMBOL). It's a $TYPE, with a mass of $MASS amu. $NAME has a melting point of $MELT_POINT celsius and a boiling point of $BOIL_POINT celsius."
  else
    echo "I could not find that element in the database."
  fi
else
  echo Please provide an element as an argument.
fi
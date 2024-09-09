PSQL="psql -X --username=freecodecamp --dbname=periodic_table --tuples-only -c"

#Update type_id
#Get type and atomic number
# echo "$($PSQL "SELECT atomic_number, type FROM properties;")" | while read NUMBER BAR TYPE
# do
#get type id
#   TYPE_ID=$($PSQL "SELECT type_id FROM types WHERE type = '$TYPE';") 
#use atomic number to update the correspondig type id
#   echo $($PSQL "UPDATE properties SET type_id = $TYPE_ID WHERE atomic_number = $NUMBER;")
# done

#Capitalize symbol
#get symbol
# echo "$($PSQL "SELECT atomic_number, symbol FROM elements;")" | while read NUMBER BAR SYMBOL
# do
#   #capitalize symbol
#   CAP_SYMBOL=$(echo $SYMBOL | sed 's/\b\w/\u&/')
#   echo $($PSQL "UPDATE elements SET symbol = '$CAP_SYMBOL' WHERE atomic_number = $NUMBER;")
# done

#Delete fake element
#delete referencing row in properties first
# echo $($PSQL "DELETE FROM properties WHERE atomic_number = 1000;")
# #then delete the referenced row
# echo $($PSQL "DELETE FROM elements WHERE atomic_number = 1000;")

#Drop type column from properties
# echo $($PSQL "ALTER TABLE properties DROP COLUMN type;")

#Remove trailing zeros
# echo "$($PSQL "SELECT atomic_number, atomic_mass FROM properties;")" | while read NUMBER BAR MASS
# do
#   #remove trailing 0's, [0-9]+ matches one or more digits, \. matches a dot, [0-9]* matches 0 or more digits and 0*$ matches no zeros or more at the end of a string
#   #the ^ matches a pattern at the beginning of the string and first expression in () is parsed to \1
#   ROUNDED_MASS=$(echo $MASS | sed -E 's/^([0-9]+\.[0-9]*[1-9])0+$/\1/')
#   #Update table
#   echo $($PSQL "UPDATE properties SET atomic_mass = $ROUNDED_MASS WHERE atomic_number = $NUMBER")
# done

#Add elements
NUMBER=$1; SYMBOL=$2; NAME=$3; MASS=$4; MELT_POINT=$5; BOIL_POINT=$6; TYPE=$7
#Get type_id
TYPE_ID=$($PSQL "SELECT type_id FROM types WHERE type = '$TYPE';")
#Update
echo $($PSQL "INSERT INTO elements(atomic_number,symbol,name) VALUES($NUMBER,'$SYMBOL','$NAME');")
echo $($PSQL "INSERT INTO properties(atomic_number,atomic_mass,melting_point_celsius,boiling_point_celsius,type_id) VALUES($NUMBER,$MASS,$MELT_POINT,$BOIL_POINT,$TYPE_ID);")

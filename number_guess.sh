#!/bin/bash
PSQL="psql --username=freecodecamp --dbname=<database_name> -t --no-align -c"




SECRET=$(( RANDOM % 1000 + 1 ))

echo "Enter your username:"
read USERNAME
echo $USERNAME


$GET_USERNAME=$($PSQL "SELECT username FROM players WHERE username=$USERNAME")

if [[ -z $GET_USERNAME ]]
then
  echo "Welcome, $USERNAME! It looks like this is your first time here."
else
  #Get games_played
  #Get best_game

  echo "Welcome back, $USERNAME! You have played <games_played> games, and your best game took <best_game> guesses."
fi



echo "Guess the secret number between 1 and 1000:"

TRIES=0

while true; do
  read NUM
  ((TRIES++))
  if ! [[ $NUM =~ ^[0-9]+$ ]]; then
    echo -e "\nThat is not an integer, guess again:"
  else
    if [[ $NUM -eq $SECRET ]]; then
      break
    elif [[ $NUM -gt $SECRET ]]; then
      echo "It's lower than that, guess again:"
    else
      echo "It's higher than that, guess again:"
    fi
  fi


done

echo "You guessed it in $TRIES tries. The secret number was $SECRET. Nice job!"


#GET_USER_INFO=$($PSQL "SELECT p.player_id,p.username,g.score FROM players AS p LEFT JOIN games AS g ON p.player_id=g.player_id WHERE p.username='$USERNAME'")


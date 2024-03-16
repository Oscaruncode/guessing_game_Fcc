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
  echo "Welcome back, <username>! You have played <games_played> games, and your best game took <best_game> guesses."
fi



#GET_USER_INFO=$($PSQL "SELECT p.player_id,p.username,g.score FROM players AS p LEFT JOIN games AS g ON p.player_id=g.player_id WHERE p.username='$USERNAME'")


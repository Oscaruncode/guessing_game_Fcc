#!/bin/bash
PSQL="psql --username=freecodecamp --dbname=guessing_game -t --no-align -c"
SECRET=$(( RANDOM % 1000 + 1 ))

echo "Enter your username:"
read USERNAME
echo $USERNAME

# Check if the username already exists
GET_USERNAME=$($PSQL "SELECT username FROM players WHERE username='$USERNAME'")

if [[ -z $GET_USERNAME ]]; then
  echo "Welcome, $USERNAME! It looks like this is your first time here."
  # INSERT player
  INSERT_PLAYER=$($PSQL "INSERT INTO players(username) VALUES('$USERNAME')")
  # Verify successful insertion and get player_id
  PLAYER_ID=$($PSQL "SELECT player_id FROM players WHERE username='$USERNAME'")
else
  # Get player_id
  PLAYER_ID=$($PSQL "SELECT player_id FROM players WHERE username='$USERNAME'")
  # Get games_played
  GAMES_PLAYED=$($PSQL "SELECT COUNT(game_id) FROM games LEFT JOIN players USING(player_id) WHERE username='$USERNAME'")
  # Get best_game
  BEST_GAME=$($PSQL "SELECT MIN(score) FROM games LEFT JOIN players USING(player_id) WHERE username='$USERNAME'")

  echo "Welcome back, $USERNAME! You have played $GAMES_PLAYED games, and your best game took $BEST_GAME guesses."
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

# Insert game record
INSERT_GAME=$($PSQL "INSERT INTO games(player_id,score) VALUES('$PLAYER_ID',$TRIES)")

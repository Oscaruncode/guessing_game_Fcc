#!/bin/bash
PSQL="psql --username=freecodecamp --dbname=<database_name> -t --no-align -c"




SECRET=$(( RANDOM % 1000 + 1 ))


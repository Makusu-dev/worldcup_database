#! /bin/bash

if [[ $1 == "test" ]]
then
  PSQL="psql --username=postgres --dbname=worldcuptest -t --no-align -c"
else
  PSQL="psql --username=freecodecamp --dbname=worldcup -t --no-align -c"
fi

# Do not change code above this line. Use the PSQL variable above to query your database.

while IFS="," read -r year round team1 team2 score_team1 score_team2
do
   echo "$($PSQL "INSERT INTO teams(name) VALUES('$team1')")"
   echo "$($PSQL "INSERT INTO teams(name) VALUES('$team2')")"
   winner_id="$($PSQL "SELECT team_id FROM teams WHERE name = '$team1'")";
   opponent_id="$($PSQL "SELECT team_id FROM teams WHERE name = '$team2'")";
   echo "$($PSQL "INSERT INTO games(year,round,winner_id,opponent_id,winner_goals,opponent_goals) VALUES('$year','$round',$winner_id,$opponent_id,'$score_team1','$score_team2')")"
done < <(tail -n +2 games.csv)


#!bin/bash

scrapers_to_run=( "scrapers/scrape_championship_players.py" "scrapers/scrape_championship_teams.py" "scrapers/scrape_players.py" "scrapers/scrape_teams.py" )

echo "Starting scrapers..."
for script in "${scrapers_to_run[@]}"
do
  echo "Running $script..."
  python $script --update_db
done
echo "Finished running scrapers."
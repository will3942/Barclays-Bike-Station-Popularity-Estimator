Barclays-Bike-Station-Popularity-Estimator
==========================================

A Ruby app that live tracks when bikes are added or removed from any Barclays Cycle Hire bike station in London, in order to estimate the popularity of every bike station in comparison with each other over time.

Setting up for use:
- Ensure the prerequisites as defined in "config.rb" are installed.
- Add your own MySQL server details to "database.php", "db.rb" and "request.rb".

Now just run "db.rb", then keep "request.rb" running, and just refresh "index.php" whenever you want to see the data collected so far.

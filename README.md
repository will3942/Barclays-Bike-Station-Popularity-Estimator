Barclays-Bike-Station-Popularity-Estimator
==========================================

A Ruby app that live tracks when bikes are added or removed from any Barclays Cycle Hire bike station in London, in order to estimate the popularity of every bike station in comparison with each other over time.  

#Setting up for use 
- Add your own MySQL server details to *db.rb*, *request.rb* and *web.rb*  
- Run *db.rb* to setup the initial database.  
- Keep *request.rb* running (e.g `ruby request.rb &`)  
- Keep *web.rb* running (e.g `ruby web.rb&`) and make a note of the port it displays. Optional arguments include -o HOSTNAME and -p PORT for specifying the hostname and port respectively for the app to run on.
- Create an nginx config to forward requests on a domain to that port (if necessary or just make all requests to IP:PORT as shown above).

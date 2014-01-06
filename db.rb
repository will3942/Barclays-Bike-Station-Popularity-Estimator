require "bundler/setup"
require "net/http"
require "uri"
require "xmlsimple"
require "mysql2"

db = Mysql2::Client.new(:host => "DB_SERVER", :username => "DB_USERNAME", :password => "DB_PASSWORD", :database => "DB_DATABASE")
uri = URI.parse("http://www.tfl.gov.uk/tfl/syndication/feeds/cycle-hire/livecyclehireupdates.xml")
response = Net::HTTP.get_response(uri).body
data = XmlSimple.xml_in(response, { 'ForceArray' => false })
i = 0

db.query("DROP TABLE IF EXISTS Popularity")
db.query("CREATE TABLE Popularity(Id INT PRIMARY KEY, Name VARCHAR(50), Changes INT, TimeDateChanged TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP, Latitude VARCHAR(20), Longitude VARCHAR(20))")

data["station"].each do
	db.query("INSERT INTO Popularity(Id, Name, Changes, Latitude, Longitude) VALUES ('" + data["station"][i]["id"] + "', '" + data["station"][i]["name"].gsub("'", %q(\\\')).gsub(" ,", ",").gsub(/\u2019/, %q(\\\')) + "', '0', '" + data["station"][i]["lat"] + "', '" + data["station"][i]["long"] + "')")
	i += 1
end

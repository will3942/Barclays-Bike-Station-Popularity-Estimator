require "bundler/setup"
require "net/http"
require "uri"
require "xmlsimple"
require "mysql2"
require "logger"

db = Mysql2::Client.new(:host => "DB_SERVER", :username => "DB_USERNAME", :password => "DB_PASSWORD", :database => "DB_DATABASE")
uri = URI.parse("http://www.tfl.gov.uk/tfl/syndication/feeds/cycle-hire/livecyclehireupdates.xml")
previousBikes = Array.new
currentBikes = Array.new
log = Logger.new("log.txt")

while true do
	i = 0
	response = Net::HTTP.get_response(uri).body

	begin
		data = XmlSimple.xml_in(response, { 'ForceArray' => false })
	rescue Exception => e
		log.debug e.message
	end

	if previousBikes.length == 0
		data["station"].each do |station|
			previousBikes[Integer(station["id"])] = Array.new
			previousBikes[Integer(station["id"])][0] = station["nbBikes"]
			previousBikes[Integer(station["id"])][1] = 0
			currentBikes[Integer(station["id"])] = Array.new
			currentBikes[Integer(station["id"])][0] = station["nbBikes"]
			currentBikes[Integer(station["id"])][1] = 0
		end
	else
		data["station"].each do |station|
			currentBikes[Integer(station["id"])][0] = station["nbBikes"]
		end

		previousBikes.each do |station|
			if currentBikes[i] != nil && currentBikes[i][0] != station[0]
				currentBikes[i][1] += 1
				db.query("UPDATE Popularity SET Changes=" + currentBikes[i][1].to_s() + " WHERE Id=" + i.to_s())
				station[0] = currentBikes[i][0]
				station[1] = currentBikes[i][1]
			end

			i += 1
		end
	end

	sleep 10
end

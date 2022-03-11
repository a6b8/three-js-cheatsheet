require 'net/http'
require "active_support/core_ext/hash/indifferent_access"
require 'json'

url = 'https://api.github.com/users/simondevyoutube/repos'

datas = []
scrape = true

for index in 1..2
    uri = URI( "#{url}?page=#{index}" )
    response = Net::HTTP.get( uri )
    data = JSON.parse( response )
    data = {
        :data => data
    }

    data = data.with_indifferent_access
    datas.push( data[:data] )
end

datas = datas.flatten()

File.open( 'simon-dev--github.json', "w" ) do | f |
  f.write( JSON.pretty_generate( { data: datas } ) )
end
require 'json'
require "active_support/core_ext/hash/indifferent_access"

file = File.read( 'simon-dev--github.json' )
data = JSON.parse( file )
data = data.with_indifferent_access

data[:data] = data[:data].map do | a |  
    {
        name: a[:name],
        url: a[:html_url],
        youtube: '',
        folder: ''
    }
end

File.open( 'simon-dev--struct.json', "w" ) do | f |
    f.write( JSON.pretty_generate( data ) )
end



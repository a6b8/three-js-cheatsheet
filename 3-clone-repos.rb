require './modules/readme'
require 'json'
require "active_support/core_ext/hash/indifferent_access"

path = 'struct.json'
txt = File.read( path )
json = JSON.parse( txt )
data = json.with_indifferent_access

cmds = data[:data].map { | a | 
    "git clone #{a[:url]}.git ./repos/#{a[:url].split('/').last}/" }

# cmds.each.with_index do | cmd, index |
#    puts "#{index}. #{cmd}"
#    system( cmd )
# end

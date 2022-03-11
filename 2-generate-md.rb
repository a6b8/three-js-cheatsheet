require './modules/readme'
require 'json'
require 'redcarpet'
require "active_support/core_ext/hash/indifferent_access"

path_struct = 'struct.json'

readme = Readme.generate( path_struct )

html = Markdown.new( readme ).to_html
File.open( './docs/index.html', "w" ) { | f |  f.write( html ) }
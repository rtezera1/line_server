#!/usr/bin/env ruby

require 'sinatra'
require 'shotgun'
require 'thin'
require './lib/lineParser.rb'

get '/lines/:line' do
  # the line selected during request
  line = params['line']
  # the file selected to server
  input_file = ARGV[1]
  # create object out of the file
  file_object = LineParser.new(input_file)
  # convert the file object into a hash
  article_hash = file_object.to_hash
  # if the file path is not valid throw an exception
  if article_hash.class == Hash
    # if the line requested is within the line of the file
    # return the HTTP status and the requested line
    # otherwise return 413 and a message
    if line.to_i < article_hash.keys[-1] && line.to_i > 0
      status 200
      phrase = article_hash[line.to_i]
      "HTTP status #{status} \n #{phrase}"
    else
      status 413
      "HTTP status #{status} \n Line out of range"
    end
  else
    return article_hash + " #{input_file}"
  end
end

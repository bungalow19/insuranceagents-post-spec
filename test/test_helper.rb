require 'rubygems'
require 'nokogiri'
require 'test/unit'

def schema(file)
  File.open(File.join(File.dirname(__FILE__), '..', file + '.xsd'))
end
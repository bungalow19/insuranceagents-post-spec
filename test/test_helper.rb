require 'rubygems'
require 'nokogiri'
require 'test/unit'

def schema(file)
  File.open(File.join(File.dirname(__FILE__), '..', file + '.xsd'))
end

module AssertDifference
  def assert_difference(value_proc, diff = 1)
    old_value = value_proc.call
    yield
    assert_equal diff, (old_value - value_proc.call).abs
  end
  
  def assert_valid(doc, xsd)
    errors = xsd.validate(doc).collect{ |error|
      error.message
    }.join("\n")
    
    assert xsd.valid?(doc), errors
  end
end

Test::Unit::TestCase.send(:include, AssertDifference)
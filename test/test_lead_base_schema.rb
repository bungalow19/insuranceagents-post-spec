require 'test_helper'

class TestLeadBaseSchema < Test::Unit::TestCase
  def setup
    @xsd = Nokogiri::XML::Schema(schema('build/schema'))
  end
  
  def test_can_load_schema
    assert @xsd
  end
  
  def teardown
  end
end
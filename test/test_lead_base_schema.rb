require 'test_helper'

class TestLeadBaseSchema < Test::Unit::TestCase
  def setup
    @xsd = Nokogiri::XML::Schema(schema('schema'))
  end
  
  def test_can_load_schema
    assert @xsd
  end
  
  def test_accepts_auto_xml
    xml = File.read(File.join(File.dirname(__FILE__), '..', 'examples', 'single_auto.xml'))
    @doc = Nokogiri::XML(xml)
    assert_valid(@doc, @xsd)
  end
  
  def teardown
  end
end
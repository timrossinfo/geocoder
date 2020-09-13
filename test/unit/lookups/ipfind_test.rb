# encoding: utf-8
require 'test_helper'

class IpfindTest < GeocoderTestCase

  def setup
    Geocoder.configure(:ip_lookup => :ipfind)
  end

  def test_ipfind_lookup_address
    result = Geocoder.search("8.8.8.8").first
    assert_equal "California", result.state
    assert_equal "CA", result.state_code
    assert_equal "", result.postal_code
    assert_equal "US", result.country_code
    assert_equal "Mountain View, California, United States", result.address
  end

  def test_ipfind_lookup_loopback_address
    result = Geocoder.search("127.0.0.1").first
    assert_equal "127.0.0.1", result.ip
    assert_equal "RD",        result.country_code
    assert_equal "Reserved",  result.country
  end
end

require "geocoder/results/base"

module Geocoder::Result
  class Ipfind < Base
    def address(format = :full)
      "#{city}, #{state}, #{country}".sub(/^[ ,]*/, "")
    end

    def ip
      @data["ip_address"]
    end

    def postal_code
      ""
    end

    def state
      @data["region"]
    end

    def state_code
      @data["region_code"]
    end

    def self.response_attributes
      [
          ["ip_address", ""],
          ["country", ""],
          ["country_code", ""],
          ["continent", ""],
          ["continent_code", ""],
          ["city", ""],
          ["county", ""],
          ["region",""],
          ["region_code",""],
          ["timezone",""],
          ["longitude", 0],
          ["latitude", 0],
          ["currency", ""],
          ["languages", []]
      ]
    end

    response_attributes.each do |attr, default|
      define_method attr do
        @data[attr] || default
      end
    end
  end
end

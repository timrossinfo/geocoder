# ovi.com store

require 'geocoder/lookups/base'
require 'geocoder/results/ovi'

module Geocoder::Lookup
  class Ovi < Base

    private # ---------------------------------------------------------------

    def results(query)
      return [] unless doc = fetch_data(query)
      return [] unless doc['Response'] && doc['Response']['View']
      if r=doc['Response']['View']
        return [] if r.nil? || !r.is_a?(Array) || r.empty?
        return r.first['Result']
      end
      []
    end

    def query_url_params(query)
      super.merge(
        :searchtext=>query.sanitized_text,
        :gen=>1,
        :app_id=>api_key,
        :app_code=>api_code
      )
    end

    def api_key
      if a=Geocoder::Configuration.api_key
        return a.first if a.is_a?(Array)
      end
    end

    def api_code
      if a=Geocoder::Configuration.api_key
        return a.last if a.is_a?(Array)
      end
    end

    def query_url(query)
      "http://lbs.ovi.com/search/6.2/geocode.json?" + url_query_string(query)
    end
  end
end

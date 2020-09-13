require 'geocoder/lookups/base'
require 'geocoder/results/ipfind'

module Geocoder::Lookup
  class Ipfind < Base

    def name
      "IP Find"
    end

    def supported_protocols
      [:http, :https]
    end

    private # ----------------------------------------------------------------

    def base_query_url(query)
      "#{protocol}://api.ipfind.com/?"
    end

    def query_url_params(query)
      {
        ip: query.sanitized_text,
        auth: configuration.api_key
      }.merge(super)
    end

    def results(query)
      # don't look up a loopback or private address, just return the stored result
      return [reserved_result(query.text)] if query.internal_ip_address?

      if !(result = fetch_data(query)).is_a?(Hash) or result["error"]
        []
      else
        [result]
      end
    end

    def reserved_result(ip)
      {
        "ip_address"   => ip,
        "country"      => "Reserved",
        "country_code" => "RD"
      }
    end
  end
end

require 'httparty/response/ids'
require 'httparty/response/paginate'

module HTTParty
  module ResponseExt

    # Get the return mode from request.
    def retmode
      request.options[:query][:retmode]
    end

    def xml?
      retmode == :xml
    end

    def esearch_request?
      request.path.to_s.match /esearch/
    end

  end
end

HTTParty::Response.send :include, HTTParty::ResponseExt

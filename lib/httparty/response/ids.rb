module HTTParty

  module ResponseIds

    # For ESearch, add convenience method that parses ids and converts to array of integers.
    # Only works if either no retern mode specified or if it is :xml.
    def ids
      if parse_ids?
        return @ids if @ids
        id_list = parsed_response['eSearchResult']['IdList']
        if id_list
          id_content = id_list['Id']
          id_content = [id_content].flatten
          @ids = id_content.map(&:to_i)
        else
          @ids = []
        end
      end
    end

    private

    # Parse only if this is an ESearch request and in xml format.
    def parse_ids?
      esearch_request? && (retmode.nil? || xml?)
    end

  end

end

HTTParty::Response.send :include, HTTParty::ResponseIds

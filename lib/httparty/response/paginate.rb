module HTTParty

    module ResponsePaginate

        # Return the count of items resulting of the query
        def Count
            if esearch_request?
                return @count if @count
                c = parsed_response["eSearchResult"]["Count"]
                if c
                    @count = c.to_i
                else
                    @count = 0
                end
            end
        end

        # When provided, ESearch will post the results of the search operation to this pre-existing WebEnv, thereby appending the results to the existing environment.
        # In addition, providing WebEnv allows query keys to be used in term so that previous search sets can be combined or limited.
        # As described above, if WebEnv is used, usehistory must be set to 'y'.
        def webEnv
            if esearch_request?
                return @webEnv if @webEnv
                we = parsed_response["eSearchResult"]["WebEnv"]
                @webEnv = we || ""
            end
        end

        # This integer specifies which of the UID lists attached to the given Web Environment will be used as input to ESummary.
        # Query keys are obtained from the output of previous ESearch, EPost or ELink calls.
        # The query_key parameter must be used in conjunction with WebEnv.
        def queryKey
            if esearch_request?
                return @queryKey if @queryKey
                qk = parsed_response["eSearchResult"]["QueryKey"]
                @queryKey = qk || ""
            end
        end

    end
end


HTTParty::Response.send :include, HTTParty::ResponsePaginate

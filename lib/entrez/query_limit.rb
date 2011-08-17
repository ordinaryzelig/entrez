module Entrez
  module QueryLimit

    private

    # NCBI does not allow more than 3 requests per second.
    # If the last 3 requests happened within the last 1 second,
    # sleep for enough time to let a full 1 second pass before the next request.
    # Add current time to queue.
    def respect_query_limit
      now = Time.now.to_f
      three_requests_ago = request_times[-3]
      request_times << now
      return unless three_requests_ago
      time_for_last_3_requeests = now - three_requests_ago
      enough_time_has_passed = time_for_last_3_requeests >= 1.0
      unless enough_time_has_passed
        sleep_time = 1 - time_for_last_3_requeests
        STDERR.puts "sleeping #{sleep_time}"
        sleep(sleep_time)
      end
    end

    def request_times
      @request_times ||= []
    end

    # Only way to set this should be through requiring entrez/spec_helpers and
    # calling Entrez.ignore_query_limit(&block).
    def ignore_query_limit?
      !!@ignore_query_limit
    end

  end
end

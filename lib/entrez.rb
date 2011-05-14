require 'httparty'
require 'query_string_normalizer'

class Entrez

  include HTTParty
  base_uri 'http://eutils.ncbi.nlm.nih.gov/entrez/eutils'
  default_params tool: 'ruby', email: (ENV['ENTREZ_EMAIL'] || raise('please set ENTREZ_EMAIL environment variable'))
  query_string_normalizer QueryStringNormalizer

  class << self

    def EFetch(db, params = {})
      perform '/efetch.fcgi', db, params
    end

    def ESummary(db, params = {})
      perform '/esummary.fcgi', db, params
    end

    def ESearch(db, search_terms = {}, params = {})
      params[:term] = convert_search_term_hash(search_terms)
      perform '/esearch.fcgi', db, params
    end

    def perform(utility_path, db, params = {})
      respect_query_limit
      request_times << Time.now.to_f
      get utility_path, :query => {db: db}.merge(params)
    end

    private

    def respect_query_limit
      three_requests_ago = request_times[-3]
      return unless three_requests_ago
      three_requests_ago = three_requests_ago.to_f
      now = Time.now.to_f
      enough_time_has_passed = now > three_requests_ago + 1
      unless enough_time_has_passed
        STDERR.puts "sleeping #{now - three_requests_ago}"
        sleep(now - three_requests_ago)
      end
    end

    def request_times
      @request_times ||= []
    end

    # Take a ruby hash and convert it to an ENTREZ search term.
    # E.g. convert_search_term_hash {WORD: 'low coverage', SEQS: 'inprogress'}
    # #=> 'low coverage[WORD]+AND+inprogress[SEQS]'
    def convert_search_term_hash(hash)
      hash.map do |field, value|
        "#{value}[#{field}]"
      end.join('+AND+')
    end

  end

end

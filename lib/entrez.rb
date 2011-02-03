require 'httparty'

class Entrez

  include HTTParty
  base_uri 'http://eutils.ncbi.nlm.nih.gov/entrez/eutils'
  default_params tool: 'ruby', email: (ENV['ENTREZ_EMAIL'] || raise('please set ENTREZ_EMAIL environment variable'))

  class << self

    def efetch(db, params = {})
      get '/efetch.fcgi', :query => {db: db}.merge(params)
    end

  end

end

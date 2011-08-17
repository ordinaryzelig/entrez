class Entrez

  class << self

    def options
      @options ||= {respect_query_limit: true}
    end

  end

end

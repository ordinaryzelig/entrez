module Macros

  def fixture_file(file_name)
    File.open(File.join(File.dirname(__FILE__), 'fixtures/', file_name))
  end

  # Return how long it takes to run block.
  def timer
    start_time = Time.now
    yield
    end_time = Time.now
    end_time - start_time
  end

  # Use FakeWeb to simulate Entrez service with contents of fixture file.
  # Since the generated URL is a bit difficult to capture,
  # Faked uri will just match regular expression of service.
  # When block ends, clean registry.
  # Ignore Entrez query limit unless told not to.
  def fake_service(service, fixture_file_name, options = {}, &block)
    file_contents = fixture_file(fixture_file_name).read
    FakeWeb.register_uri(:get, Regexp.new(service.to_s.downcase), body: file_contents, content_type: 'text/xml')
    if options.fetch(:ignore_query_limit, true)
      Entrez.ignore_query_limit(&block)
    else
      block.call
    end
  ensure
    FakeWeb.clean_registry
  end

end

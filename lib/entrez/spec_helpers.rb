# IGNORING THE QUERY LIMIT IS FOR TESTING ONLY WHERE NO REQUESTS ARE MADE TO NCBI.
# WHEN IGNORING, REQUESTS SHOULD BE STUBBED/FAKED.

Entrez.extend(Module.new do

  attr_writer :ignore_query_limit

  # For the duration of the block, Entrez requests will ignore query limit.
  def ignore_query_limit(&block)
    self.ignore_query_limit = true
    block.call
    self.ignore_query_limit = false
  end

end)

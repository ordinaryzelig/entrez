Entrez.extend(Module.new do

  # For the duration of the block, Entrez requests will ignore query limit.
  # FOR TESTING ONLY WHERE NO REQUESTS ARE MADE TO NCBI.
  # REQUESTS MUST BE STUBBED/FAKED.
  def ignore_query_limit(&block)
    @ignore_query_limit = true
    block.call
    @ignore_query_limit = false
  end

end)

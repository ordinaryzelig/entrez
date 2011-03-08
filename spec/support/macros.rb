module Macros

  def file_fixture(file_name)
    File.open(File.join(File.dirname(__FILE__), 'fixtures/', file_name)).read
  end

  # Return how long it takes to run block.
  def timer
    start_time = Time.now
    yield
    end_time = Time.now
    end_time - start_time
  end

end

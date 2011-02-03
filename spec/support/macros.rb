module Macros

  def file_fixture(file_name)
    File.open(File.join(File.dirname(__FILE__), 'fixtures/', file_name)).read
  end

end

require 'awesome_print'
require 'fakeweb'
require 'pathname'

# Require the gem source.
require File.join(Pathname(__FILE__).dirname.expand_path, '../lib/entrez')
require 'entrez/spec_helpers'

# Require spec/support files.
Dir[File.expand_path("../support/**/*.rb", __FILE__)].each {|f| require f}

RSpec.configure do |config|
  config.include(Macros)
end

# Default return mode to XML.
Entrez.default_params(
  retmode: :xml,
)

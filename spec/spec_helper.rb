$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)
require 'spokesman'
require 'json_spec'
RSpec.configure do |config|
  config.include JsonSpec::Helpers
end
require 'time'
require 'rspec'
require 'fuubar'
require 'rspec/its'

require_relative '../lib/scrap_movies'

# See http://rubydoc.info/gems/rspec-core/RSpec/Core/Configuration
RSpec.configure do |config|
  config.fuubar_progress_bar_options = { format: 'My Fuubar! <%B> %p%% %a' }
end

RSpec::Matchers.define_negated_matcher :not_change, :change

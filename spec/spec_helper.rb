require 'CSV'
require 'date'
require 'rspec'
require 'fuubar'
require 'rspec/its'
require_relative '../movie_collection'
require_relative '../movie'
require_relative '../netflix'
require_relative '../theatre'
require_relative '../ancient_movie'
require_relative '../classic_movie'
require_relative '../modern_movie'
require_relative '../new_movie'

# See http://rubydoc.info/gems/rspec-core/RSpec/Core/Configuration
RSpec.configure do |config|
  config.fuubar_progress_bar_options = { format: 'My Fuubar! <%B> %p%% %a' }
end

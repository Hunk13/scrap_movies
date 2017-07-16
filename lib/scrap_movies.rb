require 'csv'
require 'date'
require 'time'
require 'pry'
require 'awesome_print'
require 'colorize'
require 'money'

require_relative 'scrap_movies/cash_desk'
require_relative 'scrap_movies/movie'
require_relative 'scrap_movies/classic_movie'
require_relative 'scrap_movies/modern_movie'
require_relative 'scrap_movies/ancient_movie'
require_relative 'scrap_movies/new_movie'
require_relative 'scrap_movies/movie_collection'
require_relative 'scrap_movies/netflix'
require_relative 'scrap_movies/theatre'

I18n.enforce_available_locales = false

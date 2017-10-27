require 'rack/test'
require 'sinatra'
require 'pry'
require 'json'

require_relative '../lib/all'

RSpec.configure do |config|
  config.include Rack::Test::Methods
end

def app
  GameOfShutl::Application
end

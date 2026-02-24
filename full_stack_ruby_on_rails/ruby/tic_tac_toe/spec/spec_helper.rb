# spec/spec_helper.rb

require 'rspec'
require 'rainbow'
require_relative '../lib/board'
require_relative '../lib/player'
require_relative '../lib/computer'
require_relative '../lib/game'

RSpec.configure do |config|
  config.color = true
  config.formatter = :documentation
end

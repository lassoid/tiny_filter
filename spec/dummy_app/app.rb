# frozen_string_literal: true

require "tiny_filter"
require "active_record"
require "sequel"
Dir["#{__dir__}/app/filters/**/*.rb"].each { |f| require_relative f }
Dir["#{__dir__}/app/models_active_record/**/*.rb"].each { |f| require_relative f }
Dir["#{__dir__}/app/models_sequel/**/*.rb"].each { |f| require_relative f }

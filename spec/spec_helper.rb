# frozen_string_literal: true

require "sequel"
require "logger"

def reinitialize_database
  db_file_path = "#{__dir__}/dummy_app/db/db.sqlite3"

  # Delete old DB if it exists
  File.delete(db_file_path) if File.exist?(db_file_path)

  # Create DB
  Sequel.extension :migration
  Sequel.connect(
    adapter: "sqlite",
    database: "#{__dir__}/dummy_app/db/db.sqlite3",
    logger: Logger.new("#{__dir__}/log/log.txt"),
  ) do |db|
    Sequel::Migrator.run(db, "#{__dir__}/dummy_app/db/migrations")
  end
end

RSpec.configure do |config|
  # Enable flags like --only-failures and --next-failure
  config.example_status_persistence_file_path = ".rspec_status"

  # Disable RSpec exposing methods globally on `Module` and `main`
  config.disable_monkey_patching!

  config.expect_with :rspec do |c|
    c.syntax = :expect
  end
end

RSpec::Matchers.define_negated_matcher :exclude, :include

reinitialize_database

require_relative "dummy_app/app"

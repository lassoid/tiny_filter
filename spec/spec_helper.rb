# frozen_string_literal: true

require "sequel"
require "logger"
require "database_cleaner/active_record"
require "database_cleaner/sequel"

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

  # Run specs in random order to surface order dependencies. If you find an
  # order dependency and want to debug it, you can fix the order by providing
  # the seed, which is printed after each run.
  #     --seed 1234
  config.order = :random

  # Seed global randomization in this process using the `--seed` CLI option.
  # Setting this allows you to use `--seed` to deterministically reproduce
  # test failures related to randomization by passing the same `--seed` value
  # as the one that triggered the failure.
  Kernel.srand config.seed

  config.before(:suite) do
    DatabaseCleaner[:active_record].strategy = :transaction
    DatabaseCleaner[:sequel].strategy = :transaction
  end

  config.around do |example|
    DatabaseCleaner.cleaning do
      example.run
    end
  end
end

RSpec::Matchers.define_negated_matcher :exclude, :include

reinitialize_database

require_relative "dummy_app/app"

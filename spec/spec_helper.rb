# frozen_string_literal: true

require "tiny_filter"
require "active_record"
require_relative "dummy_app/app/models/post"
require_relative "dummy_app/app/models/post/comment"
require_relative "dummy_app/app/filters/post/comment_filter"
require_relative "dummy_app/app/filters/custom_post_filter"

class InitializeDb < ActiveRecord::Migration[6.0]
  def change
    create_table :posts do |t|
      t.string :title
      t.text :description
      t.datetime :created_at
    end

    create_table :post_comments do |t|
      t.text :content
      t.datetime :created_at
    end
  end
end

def reinitialize_database
  db_file_path = "#{__dir__}/dummy_app/db/db.sqlite3"

  # Delete old DB if exists
  File.delete(db_file_path) if File.exist?(db_file_path)

  # Create DB
  ActiveRecord::Base.establish_connection(adapter: "sqlite3", database: db_file_path)
  ActiveRecord::Migration.run(InitializeDb)
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

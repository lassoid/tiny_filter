# frozen_string_literal: true

ActiveRecord::Base.establish_connection(
  adapter: "sqlite3",
  database: "spec/dummy_app/db/db.sqlite3",
)

class ApplicationRecord < ActiveRecord::Base
  include TinyFilter::Concern

  self.abstract_class = true
end

# frozen_string_literal: true

Sequel::Model.db = Sequel.connect(
  adapter: "sqlite",
  database: "spec/dummy_app/db/db.sqlite3",
  logger: Logger.new("spec/log/log.txt"),
)

AbstractModel = Class.new(Sequel::Model)
class AbstractModel
  include TinyFilter::Concern
end

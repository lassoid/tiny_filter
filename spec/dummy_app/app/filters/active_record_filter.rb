# frozen_string_literal: true

# rubocop:disable Rails/WhereRange
class ActiveRecordFilter < TinyFilter::Base
  filters :from do |scope, value|
    scope.where("created_at >= ?", value)
  end

  filters :to do |scope, value|
    scope.where("created_at <= ?", value)
  end
end
# rubocop:enable Rails/WhereRange

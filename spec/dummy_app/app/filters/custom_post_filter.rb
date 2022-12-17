# frozen_string_literal: true

require_relative "timestamp_filter"

class CustomPostFilter < TimestampFilter
  filters :title do |scope, value|
    scope.where(title: value)
  end

  filters :description do |scope, value|
    scope.where(description: value)
  end
end

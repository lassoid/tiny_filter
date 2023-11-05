# frozen_string_literal: true

require_relative "active_record_filter"

class CustomPostFilter < ActiveRecordFilter
  filters :title do |scope, value|
    scope.where(title: value)
  end

  filters :description do |scope, value|
    scope.where(description: value)
  end
end

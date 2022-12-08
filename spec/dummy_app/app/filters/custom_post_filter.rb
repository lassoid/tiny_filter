# frozen_string_literal: true

require_relative "application_filter"

class CustomPostFilter < ApplicationFilter
  filters :title do |scope, value|
    scope.where(title: value)
  end

  filters :description do |scope, value|
    scope.where(description: value)
  end

end

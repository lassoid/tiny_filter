# frozen_string_literal: true

require_relative "sequel_filter"

class CustomArtistFilter < SequelFilter
  filters :name do |scope, value|
    scope.where(name: value)
  end
end

# frozen_string_literal: true

require_relative "../sequel_filter"
require_relative "../../models_sequel/artist"

class Artist
  class AlbumFilter < SequelFilter
    filters :name do |scope, value|
      scope.where(name: value)
    end
  end
end

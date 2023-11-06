# frozen_string_literal: true

require_relative "abstract_model"

class Artist < AbstractModel
  class << self
    def filter_class
      CustomArtistFilter
    end
  end
end

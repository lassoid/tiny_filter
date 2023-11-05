# frozen_string_literal: true

require_relative "../abstract_model"
require_relative "../artist"

class Artist
  class Album < AbstractModel
    many_to_one :artist
  end
end

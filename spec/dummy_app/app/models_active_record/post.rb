# frozen_string_literal: true

require_relative "application_record"

class Post < ApplicationRecord
  class << self
    def filter_class
      CustomPostFilter
    end
  end
end

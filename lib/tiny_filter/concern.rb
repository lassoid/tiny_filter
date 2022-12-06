# frozen_string_literal: true

module TinyFilter
  module Concern
    extend ActiveSupport::Concern

    included do
      scope :filter_by, ->(**args) { TinyFilter::FilterFinder.find(self).search(self, **args) }
    end

  end
end

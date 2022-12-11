# frozen_string_literal: true

module TinyFilter
  module Concern
    extend ActiveSupport::Concern

    included do
      if defined?(ActiveRecord::Base) && self <= ActiveRecord::Base
        scope :filter_by, ->(args = {}) { TinyFilter::FilterFinder.find(self).filter(self, args) }
      else
        raise Error, "unable to include TinyFilter::Concern in #{self} that is not an ActiveRecord::Base descendant"
      end
    end
  end
end

# frozen_string_literal: true

module TinyFilter
  module Concern
    class << self
      def included(other)
        if defined?(ActiveRecord::Base) && other <= ActiveRecord::Base
          other.scope :filter_by, ->(args = {}) { TinyFilter::FilterFinder.find(self).filter(self, args) }
        elsif defined?(Sequel::Model) && other <= Sequel::Model
          other.dataset_module do
            def filter_by(args = {})
              TinyFilter::FilterFinder.find(self).filter(self, args)
            end
          end
        else
          raise Error, "unable to include TinyFilter::Concern in #{other} " \
            "that is not an ActiveRecord::Base or Sequel::Model descendant"
        end
      end
    end
  end
end

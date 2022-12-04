# frozen_string_literal: true

module TinyFilter
  module Concern
    extend ActiveSupport::Concern

    class_methods do
      def filter_class
        "#{self}#{SUFFIX}".constantize
      end
    end

    included do
      scope :filter_by, ->(**args) { filter_class.search(self, **args) }
    end

  end
end

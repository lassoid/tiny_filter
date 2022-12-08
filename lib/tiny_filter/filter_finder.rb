# frozen_string_literal: true

module TinyFilter
  class FilterFinder
    SUFFIX = "Filter"

    class << self

      def find(object)
        filter_class(object)
      end

      private

      def filter_class(object)
        if object.respond_to?(:filter_class)
          object.filter_class
        elsif object.respond_to?(:model_name)
          "#{object.model_name}#{SUFFIX}".constantize
        else
          raise Error, "unable to find appropriate filter class for #{object}"
        end
      end

    end

  end
end

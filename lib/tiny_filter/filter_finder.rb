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
          Object.const_get("#{object.model_name}#{SUFFIX}")
        elsif object.respond_to?(:model)
          if object.model.respond_to?(:filter_class)
            object.model.filter_class
          else
            Object.const_get("#{object.model}#{SUFFIX}")
          end
        else
          Object.const_get("#{object}#{SUFFIX}")
        end
      rescue NameError
        raise Error, "unable to find appropriate filter class for #{object}"
      end
    end
  end
end

# frozen_string_literal: true

module TinyFilter
  class Base
    class << self
      def inherited(subclass)
        super
        dup_filters = __filters__.dup
        subclass.__filters__ = dup_filters.each { |key, value| dup_filters[key] = value.dup }
      end

      def filters(key, &block)
        __filters__[key.to_sym] = block
      end

      def filter(base_scope, args = {})
        args.inject(base_scope) do |scope, (key, value)|
          key = key.to_sym
          raise NotDefinedError, "unable to find filter :#{key} in #{self}" unless __filters__.key?(key)

          __filters__[key].call(scope, value)
        end
      end

      protected

      attr_writer :__filters__

      def __filters__
        @__filters__ ||= {}
      end
    end
  end
end

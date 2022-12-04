# frozen_string_literal: true

module TinyFilter
  class Base

    class << self

      def filters(key, &block)
        key = key.to_sym
        raise AlreadyDefinedError, "Filter already defined: #{key}" if __filters__.key?(key)

        __filters__[key] = block
      end

      def search(base_scope, **args)
        args.inject(base_scope) do |scope, (key, value)|
          raise NotDefinedError, "Filter not defined: #{key}" unless __filters__.key?(key)

          __filters__[key].call(scope, value)
        end
      end

      private

      def __filters__
        @__filters__ ||= {}
      end

    end

  end
end

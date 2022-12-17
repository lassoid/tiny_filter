# frozen_string_literal: true

module TinyFilter
  module Generators
    class FilterGenerator < ::Rails::Generators::NamedBase
      source_root File.expand_path("templates", __dir__)

      argument :keys, type: :array, required: false, default: []

      desc "This generator creates a filter for provided model"

      def create_filter
        template_file = File.join("app/filters", class_path, filter_file_name)
        template "filter.rb.tt", template_file
      end

      private

      def filter_file_name
        "#{file_name}_filter.rb"
      end
    end
  end
end

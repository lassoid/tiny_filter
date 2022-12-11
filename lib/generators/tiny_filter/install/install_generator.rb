# frozen_string_literal: true

module TinyFilter
  module Generators
    class InstallGenerator < ::Rails::Generators::Base
      source_root File.expand_path("templates", __dir__)

      desc "This generator creates an application filter"

      def copy_application_filter
        template "application_filter.rb", "app/filters/application_filter.rb"
      end

    end
  end
end

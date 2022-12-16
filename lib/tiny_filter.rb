# frozen_string_literal: true

require "active_support/concern"
require "active_support/core_ext/string/inflections"

require "tiny_filter/version"
require "tiny_filter/base"
require "tiny_filter/filter_finder"
require "tiny_filter/concern"

module TinyFilter
  class Error < StandardError; end
  class NotDefinedError < Error; end
end

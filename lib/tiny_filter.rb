# frozen_string_literal: true

require "active_support/concern"
require "active_support/core_ext/string/inflections"

require "tiny_filter/version"
require "tiny_filter/base"
require "tiny_filter/concern"

module TinyFilter
  SUFFIX = "Filter"

  class NotDefinedError < StandardError; end
  class AlreadyDefinedError < StandardError; end
end

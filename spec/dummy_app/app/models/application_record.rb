# frozen_string_literal: true

require "active_record"
require_relative "../../../../lib/tiny_filter/concern"

class ApplicationRecord < ActiveRecord::Base
  include TinyFilter::Concern

  self.abstract_class = true
end

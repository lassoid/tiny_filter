# frozen_string_literal: true

class SequelFilter < TinyFilter::Base
  filters :from do |scope, value|
    scope.where { created_at >= value }
  end

  filters :to do |scope, value|
    scope.where { created_at <= value }
  end
end

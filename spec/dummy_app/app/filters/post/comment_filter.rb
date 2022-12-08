# frozen_string_literal: true

require_relative "../application_filter"

class Post
  class CommentFilter < ApplicationFilter
    filters :from do |scope, value|
      scope.where("created_at >= ?", value)
    end

    filters :to do |scope, value|
      scope.where("created_at <= ?", value)
    end

  end
end

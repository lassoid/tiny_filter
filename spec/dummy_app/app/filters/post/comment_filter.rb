# frozen_string_literal: true

require_relative "../timestamp_filter"

class Post
  class CommentFilter < TimestampFilter
    filters :content do |scope, value|
      scope.where(content: value)
    end
  end
end

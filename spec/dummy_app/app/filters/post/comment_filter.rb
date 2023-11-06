# frozen_string_literal: true

require_relative "../active_record_filter"
require_relative "../../models_active_record/post"

class Post
  class CommentFilter < ActiveRecordFilter
    filters :content do |scope, value|
      scope.where(content: value)
    end
  end
end

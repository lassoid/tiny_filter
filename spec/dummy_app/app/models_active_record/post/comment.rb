# frozen_string_literal: true

require_relative "../application_record"
require_relative "../post"

class Post
  class Comment < ApplicationRecord
    belongs_to :post
  end
end

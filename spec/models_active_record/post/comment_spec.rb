# frozen_string_literal: true

RSpec.describe Post::Comment do
  describe "filtering" do
    let(:filter_args) { { from: Date.today.beginning_of_day, to: Date.today.end_of_day } }
    let(:post) { Post.create!(title: "Post title") }
    let!(:yesterday_comment) { described_class.create!(post: post, created_at: Date.yesterday.middle_of_day) }
    let!(:today_comment) { described_class.create!(post: post, created_at: Date.today.middle_of_day) }
    let!(:tomorrow_comment) { described_class.create!(post: post, created_at: Date.tomorrow.middle_of_day) }

    it "executes filters" do
      expect(described_class.filter_by(filter_args))
        .to include(today_comment).and exclude(yesterday_comment, tomorrow_comment)
    end
  end
end

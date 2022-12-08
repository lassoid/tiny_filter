# frozen_string_literal: true

# rubocop:disable Rails/ApplicationRecord
class MyModel < ActiveRecord::Base; end
# rubocop:enable Rails/ApplicationRecord

RSpec.describe TinyFilter::Concern do
  let(:args) { { from: Date.today.beginning_of_day, to: Date.today.end_of_day } }

  it "adds filter_by scope to model on include" do
    expect(MyModel).not_to respond_to(:filter_by)

    MyModel.include described_class

    expect(MyModel).to respond_to(:filter_by)
  end

  it "executes filter with hash provided" do
    allow(Post::CommentFilter).to receive(:search).with(anything, args)

    Post::Comment.filter_by(args)

    expect(Post::CommentFilter).to have_received(:search).with(anything, args)
  end

  it "executes filter with kwargs provided" do
    allow(Post::CommentFilter).to receive(:search).with(anything, args)

    Post::Comment.filter_by(**args)

    expect(Post::CommentFilter).to have_received(:search).with(anything, args)
  end
end

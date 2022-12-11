# frozen_string_literal: true

# rubocop:disable Rails/ApplicationRecord
class MyModel < ActiveRecord::Base; end
# rubocop:enable Rails/ApplicationRecord

class NotAModel; end

RSpec.describe TinyFilter::Concern do
  let(:args) { { from: Date.today.beginning_of_day, to: Date.today.end_of_day } }

  it "adds filter_by scope to model on include if class is an ActiveRecord::Base descendant" do
    expect(MyModel).not_to respond_to(:filter_by)

    MyModel.include described_class

    expect(MyModel).to respond_to(:filter_by)
  end

  it "raises an error if class is not an ActiveRecord::Base descendant" do
    expect do
      NotAModel.include described_class
    end.to raise_error(
      TinyFilter::Error,
      "unable to include TinyFilter::Concern in #{NotAModel} that is not an ActiveRecord::Base descendant",
    )
  end

  it "executes filter with hash provided" do
    allow(Post::CommentFilter).to receive(:filter).with(anything, args)

    Post::Comment.filter_by(args)

    expect(Post::CommentFilter).to have_received(:filter).with(anything, args)
  end

  it "executes filter with kwargs provided" do
    allow(Post::CommentFilter).to receive(:filter).with(anything, args)

    Post::Comment.filter_by(**args)

    expect(Post::CommentFilter).to have_received(:filter).with(anything, args)
  end
end

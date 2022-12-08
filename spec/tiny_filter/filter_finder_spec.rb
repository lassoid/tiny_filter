# frozen_string_literal: true

RSpec.describe TinyFilter::FilterFinder do
  describe "##find" do
    it "returns filter_class method value if it exists for AR-class" do
      expect(described_class.find(Post)).to eq(CustomPostFilter)
    end

    it "returns filter_class method value if it exists for AR-collection" do
      expect(described_class.find(Post.all)).to eq(CustomPostFilter)
    end

    it "returns class by model_name if filter_class method doesn't exist for AR-class" do
      expect(described_class.find(Post::Comment)).to eq(Post::CommentFilter)
    end

    it "returns class by model_name if filter_class method doesn't exist for AR-collection" do
      expect(described_class.find(Post::Comment.all)).to eq(Post::CommentFilter)
    end

    it "raises error if filter_class method doesn't exist and object doesn't respond to model_name" do
      object = Object.new
      expect do
        described_class.find(object)
      end.to raise_error(TinyFilter::Error, "unable to find appropriate filter class for #{object}")
    end
  end
end

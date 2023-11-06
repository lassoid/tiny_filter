# frozen_string_literal: true

RSpec.describe TinyFilter::FilterFinder do
  describe "##find" do
    it "returns the filter_class method value if it exists for AR class" do
      expect(described_class.find(Post)).to eq(CustomPostFilter)
    end

    it "returns the filter_class method value if it exists for AR collection" do
      expect(described_class.find(Post.order(:id))).to eq(CustomPostFilter)
    end

    it "returns the class by model name if filter_class method doesn't exist for AR class" do
      expect(described_class.find(Post::Comment)).to eq(Post::CommentFilter)
    end

    it "returns the class by model name if filter_class method doesn't exist for AR collection" do
      expect(described_class.find(Post::Comment.order(:id))).to eq(Post::CommentFilter)
    end

    it "returns the filter_class method value if it exists for Sequel class" do
      expect(described_class.find(Artist)).to eq(CustomArtistFilter)
    end

    it "returns the filter_class method value if it exists for Sequel dataset" do
      expect(described_class.find(Artist.order(:id))).to eq(CustomArtistFilter)
    end

    it "returns the class by model name if filter_class method doesn't exist for Sequel class" do
      expect(described_class.find(Artist::Album)).to eq(Artist::AlbumFilter)
    end

    it "returns the class by model name if filter_class method doesn't exist for Sequel dataset" do
      expect(described_class.find(Artist::Album.order(:id))).to eq(Artist::AlbumFilter)
    end

    it "raises an error if filter_class was not found" do
      object = Object.new
      expect do
        described_class.find(object)
      end.to raise_error(TinyFilter::Error, "unable to find appropriate filter class for #{object}")
    end
  end
end

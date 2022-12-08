# frozen_string_literal: true

RSpec.describe Post do
  describe "filtering" do
    let(:filter_args) { { title: "test_title_1", description: "desc_1" } }
    let!(:post) { described_class.create(title: "test_title_1", description: "desc_1") }
    let!(:post_with_other_title) { described_class.create(title: "test_title_2", description: "desc_1") }
    let!(:post_with_other_description) { described_class.create(title: "test_title_1", description: "desc_2") }

    it "executes filters" do
      expect(described_class.filter_by(filter_args))
        .to include(post).and exclude(post_with_other_title, post_with_other_description)
    end
  end
end

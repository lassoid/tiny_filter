# frozen_string_literal: true

RSpec.describe Artist do
  describe "filtering" do
    let(:filter_args) { { name: "test_name_1" } }
    let!(:artist) { described_class.create(name: "test_name_1") }
    let!(:artist_with_other_name) { described_class.create(name: "test_name_2") }

    it "executes filters" do
      expect(described_class.filter_by(filter_args))
        .to include(artist).and exclude(artist_with_other_name)
    end
  end
end

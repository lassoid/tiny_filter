# frozen_string_literal: true

RSpec.describe Artist::Album do
  describe "filtering" do
    let(:filter_args) { { from: Date.today.beginning_of_day, to: Date.today.end_of_day } }
    let(:artist) { Artist.create(name: "Artist name") }
    let!(:yesterday_album) { described_class.create(artist_id: artist.id, created_at: Date.yesterday.middle_of_day) }
    let!(:today_album) { described_class.create(artist_id: artist.id, created_at: Date.today.middle_of_day) }
    let!(:tomorrow_album) { described_class.create(artist_id: artist.id, created_at: Date.tomorrow.middle_of_day) }

    it "executes filters" do
      expect(described_class.filter_by(filter_args))
        .to include(today_album).and exclude(yesterday_album, tomorrow_album)
    end
  end
end

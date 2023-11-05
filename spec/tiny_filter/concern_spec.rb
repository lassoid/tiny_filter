# frozen_string_literal: true

# rubocop:disable Rails/ApplicationRecord
class ActiveRecordModel < ActiveRecord::Base; end
# rubocop:enable Rails/ApplicationRecord

SequelModel = Class.new(Sequel::Model)

class NotAModel; end

RSpec.describe TinyFilter::Concern do
  let(:args) { { from: Date.today.beginning_of_day, to: Date.today.end_of_day } }

  it "adds the filter_by scope to the model on include if the class is an ActiveRecord::Base descendant" do
    expect(ActiveRecordModel).not_to respond_to(:filter_by)

    ActiveRecordModel.include described_class

    expect(ActiveRecordModel).to respond_to(:filter_by)
  end

  it "adds the filter_by dataset method to the model on include if the class is an Sequel::Model descendant" do
    expect(SequelModel).not_to respond_to(:filter_by)

    SequelModel.include described_class

    expect(SequelModel).to respond_to(:filter_by)
  end

  it "raises an error if the class is not an ActiveRecord::Base or Sequel::Model descendant" do
    expect do
      NotAModel.include described_class
    end.to raise_error(
      TinyFilter::Error,
      "unable to include TinyFilter::Concern in #{NotAModel} " \
        "that is not an ActiveRecord::Base or Sequel::Model descendant",
    )
  end
end

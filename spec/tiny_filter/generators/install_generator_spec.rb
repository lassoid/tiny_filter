# frozen_string_literal: true

require "rails/generators"
require_relative "../../../lib/generators/tiny_filter/install/install_generator"

RSpec.describe TinyFilter::Generators::InstallGenerator do
  def expected_file_content
    <<~CONTENT
      # frozen_string_literal: true

      class ApplicationFilter < TinyFilter::Base

      end
    CONTENT
  end

  let(:work_path) { File.expand_path("../../tmp", __dir__) }
  let(:file_path) { "#{work_path}/app/filters/application_filter.rb" }

  after { FileUtils.rm_rf("#{work_path}/app") }

  it "creates application filter file" do
    described_class.start([], destination_root: work_path)

    expect(File).to exist(file_path)
  end

  it "creates application filter with valid content" do
    described_class.start([], destination_root: work_path)

    expect(File.read(file_path)).to eq(expected_file_content)
  end
end

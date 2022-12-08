# frozen_string_literal: true

require "rails/generators"
require_relative "../../../lib/tiny_filter/generators/tiny_filter/filter/filter_generator"

RSpec.describe TinyFilter::Generators::FilterGenerator do
  def work_path
    File.expand_path("../../tmp", __dir__)
  end

  def file_path(model_name)
    "#{work_path}/app/filters/#{model_name}_filter.rb"
  end

  def class_from_model_name(model_name)
    model_name.split("/").map(&:capitalize).join("::")
  end

  def expected_file_content(model_name, keys = [])
    <<~CONTENT
      # frozen_string_literal: true

      class #{class_from_model_name(model_name)}Filter < ::ApplicationFilter
      #{keys.any? ? expected_filter_body(keys) : nil}
      end
    CONTENT
  end

  def expected_filter_body(keys)
    keys.map do |filter_key|
      <<-CONTENT
  filters :#{filter_key} do |scope, value|
    scope
  end
      CONTENT
    end.join("\n").prepend("\n")
  end

  after { FileUtils.rm_rf("#{work_path}/app") }

  context "with simple model name" do
    let(:model_name) { "post" }

    it "creates post filter file" do
      described_class.start([model_name], destination_root: work_path)

      expect(File).to exist(file_path(model_name))
    end

    it "creates post filter without filters" do
      described_class.start([model_name], destination_root: work_path)

      expect(File.read(file_path(model_name))).to eq(expected_file_content(model_name))
    end
  end

  context "with namespaced model name" do
    let(:model_name) { "post/comment" }

    it "creates post comment filter file" do
      described_class.start([model_name], destination_root: work_path)

      expect(File).to exist(file_path(model_name))
    end

    it "creates post comment filter without filters" do
      described_class.start([model_name], destination_root: work_path)

      expect(File.read(file_path(model_name))).to eq(expected_file_content(model_name))
    end
  end

  context "with filter keys provided" do
    let(:model_name) { "post/comment" }
    let(:filter_keys) { %w[title description] }

    it "creates post comment filter file" do
      described_class.start([model_name] + filter_keys, destination_root: work_path)

      expect(File).to exist(file_path(model_name))
    end

    it "creates post comment filter with provided filters" do
      described_class.start([model_name] + filter_keys, destination_root: work_path)

      expect(File.read(file_path(model_name))).to eq(expected_file_content(model_name, filter_keys))
    end
  end
end

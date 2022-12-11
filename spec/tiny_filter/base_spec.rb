# frozen_string_literal: true

RSpec.describe TinyFilter::Base do
  describe "##filters" do
    let(:key) { :key }
    let(:proc_object) { proc { |scope, _value| scope } }

    after { described_class.instance_variable_set(:@__filters__, nil) }

    it "saves filter" do
      described_class.filters(:key, &proc_object)

      expect(described_class.instance_variable_get(:@__filters__)[key]).to eq(proc_object)
    end

    it "raises an error if filter already exists" do
      described_class.filters(:key, &proc_object)

      expect do
        described_class.filters(:key, &proc_object)
      end.to raise_error(TinyFilter::AlreadyDefinedError, "filter :#{key} defined more than once in #{described_class}")
    end
  end

  describe "##filter" do
    let(:scope) { Post::Comment }
    let(:args) { { from: Date.today.beginning_of_day, to: Date.today.end_of_day } }
    let(:filter_class) { Post::CommentFilter }

    it "executes provided filters with symbol hash keys" do
      allow(scope).to receive(:where).with("created_at >= ?", args[:from]).and_return(scope)
      allow(scope).to receive(:where).with("created_at <= ?", args[:to]).and_return(scope)

      filter_class.filter(scope, args)

      expect(scope).to have_received(:where).with("created_at >= ?", args[:from])
      expect(scope).to have_received(:where).with("created_at <= ?", args[:to])
    end

    it "executes provided filters with string hash keys" do
      allow(scope).to receive(:where).with("created_at >= ?", args[:from]).and_return(scope)
      allow(scope).to receive(:where).with("created_at <= ?", args[:to]).and_return(scope)

      filter_class.filter(scope, args.stringify_keys)

      expect(scope).to have_received(:where).with("created_at >= ?", args[:from])
      expect(scope).to have_received(:where).with("created_at <= ?", args[:to])
    end

    it "raises an error if filter wasn't found" do
      expect do
        filter_class.filter(scope, undefined_filter: "test value")
      end.to raise_error(TinyFilter::NotDefinedError, "unable to find filter :undefined_filter in #{filter_class}")
    end
  end
end

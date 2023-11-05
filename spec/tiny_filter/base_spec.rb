# frozen_string_literal: true

RSpec.describe TinyFilter::Base do
  def saved_filters(klass)
    klass.instance_variable_get(:@__filters__)
  end

  let(:proc_object) { proc { |scope, _value| scope.all } }
  let(:other_proc_object) { proc { |scope, _value| scope.none } }

  after { described_class.instance_variable_set(:@__filters__, nil) }

  describe "##filters" do
    let(:key) { "test_filter#{rand(1..9)}".to_sym }

    it "saves the filter" do
      described_class.filters(key, &proc_object)

      expect(saved_filters(described_class)[key]).to eq(proc_object)
    end

    it "overrides the filter if it already exists" do
      described_class.filters(key, &proc_object)
      described_class.filters(key, &other_proc_object)

      expect(saved_filters(described_class)[key]).to eq(other_proc_object)
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

    it "raises an error if the filter doesn't exist" do
      expect do
        filter_class.filter(scope, undefined_filter: "test value")
      end.to raise_error(TinyFilter::NotDefinedError, "unable to find filter :undefined_filter in #{filter_class}")
    end
  end

  describe "##inherited" do
    it "copies dup of self filters to the subclass" do
      base_filter = described_class
      base_filter.filters(:base, &proc_object)

      sub_filter = Class.new(base_filter)
      sub_filter.filters(:sub, &other_proc_object)

      expect(saved_filters(sub_filter).keys).to contain_exactly(:base, :sub)
      expect(saved_filters(sub_filter).object_id).not_to eq(saved_filters(base_filter).object_id)
      expect(saved_filters(sub_filter)[:base].object_id).not_to eq(saved_filters(base_filter)[:base].object_id)
    end

    it "copies dup of the subclass filters to its subclass" do
      base_filter = Class.new(described_class)
      base_filter.filters(:base, &proc_object)

      sub_filter = Class.new(base_filter)
      sub_filter.filters(:sub, &other_proc_object)

      expect(saved_filters(sub_filter).keys).to contain_exactly(:base, :sub)
      expect(saved_filters(sub_filter).object_id).not_to eq(saved_filters(base_filter).object_id)
      expect(saved_filters(sub_filter)[:base].object_id).not_to eq(saved_filters(base_filter)[:base].object_id)
    end
  end
end

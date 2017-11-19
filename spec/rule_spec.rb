require "rspec"
require_relative "../lib/rule.rb"

shared_examples "Rule" do
  describe Syft::Rule do
    let(:rule_args) {{type: "item", value: 8.5, code: "001", quantity: 2}}
    subject { Syft::Rule.new(rule_args) }

    it { is_expected.to have_attributes(type: "item") }
    it { is_expected.to have_attributes(code: "001") }
    it { is_expected.to have_attributes(quantity: 2) }
    it { is_expected.to have_attributes(value: 8.5) }
    it { is_expected.to have_attributes(discount: nil) }

    it { expect{ subject.apply }.to raise_error { NotImplementedError } }
  end
end

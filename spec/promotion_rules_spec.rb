require "rspec"
require_relative "./rule_spec.rb"
require_relative "../lib/promotion_rules.rb"

describe Syft::PromotionRules do
  include_examples "Rule"
  let(:rule_1_1) {instance_double("Rule", type: "discount", value: 60, discount: 0.1)}

  subject { Syft::PromotionRules.new([rule_1_1]) }

  it { is_expected.to have_attributes(rules: [rule_1_1]) }

  it { expect{ subject.apply_rules }.to raise_error { NotImplementedError } }
end

require "rspec_helper"

describe Syft::PromotionRules do
  include_examples "Rule"
  let(:rule_1) { {type: "discount", value: 60, discount: 0.1} }

  describe "Add rules" do
    describe "Include discount rule" do
      before(:each) { subject.add_rule(rule_1) }

      it { expect(subject.rules.size).to eq(1) }
    end

  end
end

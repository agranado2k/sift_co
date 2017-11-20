require "rspec_helper"

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

    describe "Create Rules" do
      describe "Discount type" do
        let(:type) { {type: "discount"} }
        it { expect(described_class.create(type)).to be_instance_of(Syft::Rules::Discount) }
      end

      describe "Item type" do
        let(:type) { {type: "item"} }
        it { expect(described_class.create(type)).to be_instance_of(Syft::Rules::Item) }
      end
    end
  end
end

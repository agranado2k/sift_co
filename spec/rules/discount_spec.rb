require "rspec_helper"

describe Syft::Rules::Discount do
  include_examples "Rule"
  subject { Syft::Rules::Discount.new({value: 60, discount: 0.1}) }
  let(:items) {[]}

  describe "Promotion Rule 1.1" do
    describe "Checkout total over 60" do
      let(:total) { 74.2 }
      it "should give discount" do
        expect(subject.apply(items, total)).to be_within(0.1).of(66.78)
      end
    end

    describe "Checkout total lower 60" do
      let(:total) { 59 }
      it "should not give discount" do
        expect(subject.apply(items, total)).to be_within(0.1).of(59)
      end
    end
  end

  describe "Promotion Rule 1.2" do
    subject { Syft::Rules::Discount.new({value: 50, discount: 0.15}) }

    describe "Checkout total over 55" do
      let(:total) { 54.25 }
      it "should give discount" do
        expect(subject.apply(items, total)).to be_within(0.1).of(46.11)
      end
    end
  end
end

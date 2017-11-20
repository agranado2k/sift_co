require "rspec_helper"

describe Syft::Rules::Item do
  include_examples "Rule"
  let(:item1) {double("Item 1", name: "Lavender heart", price: 9.25 , code: "001")}
  let(:item2) {double("Item 2", name: "Personalised Cufflinks", price: 45, code: "002")}
  let(:item3) {double("Item 3", name: "Kids T-shirt", price: 19.95, code: "003")}

  describe "Promotion Rule 2.1" do
    subject { Syft::Rules::Item.new(value: 8.5, code: "001", quantity: 2) }

    describe "Checkout with 2 items 1" do
      let(:items) {[Syft::CheckoutItem.new(item1, 2),
                   Syft::CheckoutItem.new(item3)]}

      it "should give discount" do
        subject.apply(items)

        expect(items.first.price).to eq(8.5)
      end
    end

    describe "Checkout total with only 1 item 1" do
      subject { Syft::Rules::Item.new(value: 10, code: "003", quantity: 2) }
      let(:items) {[Syft::CheckoutItem.new(item1),
                   Syft::CheckoutItem.new(item3, 2)]}

      it "should not give discount" do
        subject.apply(items)

        expect(items.last.price).to eq(10)
      end
    end
  end
end

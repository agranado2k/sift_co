require "rspec_helper"

shared_examples "CheckoutItem" do
  describe Syft::CheckoutItem do
    let(:item1) {double("item 1", name: "Lavender heart", price: 9.25 , code: "001")}

    subject { Syft::CheckoutItem.new(item1) }

    it { is_expected.to have_attributes(code: "001") }
    it { is_expected.to have_attributes(name: "Lavender heart") }
    it { is_expected.to have_attributes(price: 9.25) }
    it { is_expected.to have_attributes(quantity: 1) }
  end
end

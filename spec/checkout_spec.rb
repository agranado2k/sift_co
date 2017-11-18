require "rspec"

require_relative "../lib/checkout"

describe Syft::Checkout do
  let(:item1) {double("Lavender heart", price: 9.25)}
  let(:item2) {double("Personalised Cufflinks", price: 45)}
  let(:item3) {double("Kids T-shirt", price: 19.95)}

  it "should calculate total price 0 from empty checkout" do
    expect(subject.total).to eq(0)
  end

  describe "Checkout with itens" do
    describe "Without Promotion Rules" do
      before(:each) do
        item1 = double("Item 1", price: 5)
        item2 = double("Item 2", price: 6)

        subject.scan(item1)
        subject.scan(item2)
      end

      it "should calculate total price scanned itens" do
        expect(subject.total).to eq(11)
      end
    end

    describe "With Promotion Rules" do
      let(:rule_1) {double("Rule 1: price over 60 pounds give 10% discount",
                   type: "discount", value: 60)}
      let(:rule_2) {double("Rule 2: 2 Lavender hearts price drops to 8.50")}

      describe "Promotion Rule 1" do
        subject { Syft::Checkout.new([rule_1]) }

        describe "Checkout total over 60" do
          before(:each) do
            subject.scan(item1)
            subject.scan(item2)
            subject.scan(item3)
          end

          it "should give discount" do
            expect(subject.total).to eq(66.78)
          end
        end

        describe "Checkout total lower 60" do
          before(:each) do
            subject.scan(item1)
            subject.scan(item2)
          end

          it "should not give discount" do
            expect(subject.total).to eq(54.25)
          end
        end

      end

    end
  end
end

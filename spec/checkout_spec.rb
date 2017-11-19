require "rspec"

require_relative "../lib/checkout"

describe Syft::Checkout do
  include_examples "CheckoutItem"

  let(:item1) {double("item 1", name: "Lavender heart", price: 9.25 , code: "001")}
  let(:item2) {double("item 2", name: "Personalised Cufflinks", price: 45, code: "002")}
  let(:item3) {double("item 3", name: "Kids T-shirt", price: 19.95, code: "003")}

  it "should calculate total price 0 from empty checkout" do
    expect(subject.total).to eq(0)
  end

  describe "Checkout with itens" do
    describe "Without Promotion Rules" do
      before(:each) do
        subject.scan(item1)
        subject.scan(item2)
      end

      it "should calculate total price from scanned itens" do
        expect(subject.total).to eq(54.25)
      end
    end

    describe "With Promotion Rules" do
      describe "Promotion Rule 1.1" do
        let(:rule_1_1) {double("Rule 1.1: price over 60 pounds give 10% discount",
                               type: "discount", value: 60, discount: 0.1)}
        subject { Syft::Checkout.new([rule_1_1]) }

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

      describe "Promotion Rule 1.2" do
        let(:rule_1_2) {double("Rule 1.2: price over 50 pounds give 15% discount",
                               type: "discount", value: 50, discount: 0.15)}
        subject { Syft::Checkout.new([rule_1_2]) }

        describe "Checkout total over 60" do
          before(:each) do
            subject.scan(item1)
            subject.scan(item2)
          end

          it "should give discount" do
            expect(subject.total).to eq(46.11)
          end
        end

      end

      describe "Promotion Rule 2.1" do
        let(:rule_2_1) {double("Rule 2: 2 Lavender hearts price drops to 8.50",
                               type: "item", value: 8.5, code: "001", quantity: 2)}
        subject { Syft::Checkout.new([rule_2_1]) }

        describe "Checkout with 2 items 1" do
          before(:each) do
            subject.scan(item1)
            subject.scan(item3)
            subject.scan(item1)
          end

          it "should give discount" do
            expect(subject.total).to eq(36.95)
          end
        end

        describe "Checkout total with only 1 item 1" do
          before(:each) do
            subject.scan(item1)
            subject.scan(item2)
            subject.scan(item2)
          end

          it "should not give discount" do
            expect(subject.total).to eq(99.25)
          end
        end

      end
    end
  end
end

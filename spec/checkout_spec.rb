require "rspec_helper"

describe Syft::Checkout do
  include_examples "CheckoutItem"
  subject{ Syft::Checkout.new(Syft::PromotionRules.new()) }

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
      let(:rule_1) { {type: "discount", discount: 0.1, value: 60} }
      let(:rule_2) { {type: "item", value: 8.5, code: "001", quantity: 2} }

      describe "Promotion Rule: If you spend over £60, then you get 10% of your purchase" do
        before(:each) do
          @promotion_rules = Syft::PromotionRules.new
          @promotion_rules.add_rule(rule_1)
        end

        describe "Checkout total over 60" do
          subject { Syft::Checkout.new(@promotion_rules) }

          before(:each) do
            subject.scan(item1)
            subject.scan(item2)
            subject.scan(item3)
          end

          it "should give discount" do
            expect(subject.total).to eq(66.78)
          end
        end
      end

      describe "Promotion Rule: If you buy 2 or more lavender hearts then the price drops to £8.50 " do
        before(:each) do
          @promotion_rules = Syft::PromotionRules.new
          @promotion_rules.add_rule(rule_2)
        end

        describe "Checkout with 2 items 001" do
          subject { Syft::Checkout.new(@promotion_rules) }

          before(:each) do
            subject.scan(item1)
            subject.scan(item3)
            subject.scan(item1)
          end

          it "should give discount" do
            expect(subject.total).to eq(36.95)
          end
        end
      end

      describe "Apply the both Rules" do
        before(:each) do
          @promotion_rules = Syft::PromotionRules.new
          @promotion_rules.add_rule(rule_1)
          @promotion_rules.add_rule(rule_2)
        end

        describe "Checkout wiht 2 items 001 and  total over 60" do
          subject { Syft::Checkout.new(@promotion_rules) }
          before(:each) do
            subject.scan(item1)
            subject.scan(item2)
            subject.scan(item1)
            subject.scan(item3)
          end

          it "should give discount" do
            expect(subject.total).to eq(73.76)
          end
        end
      end
    end
  end
end

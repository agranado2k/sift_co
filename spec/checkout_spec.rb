require "rspec"

require_relative "../lib/checkout"

describe Syft::Checkout do
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

  end
end

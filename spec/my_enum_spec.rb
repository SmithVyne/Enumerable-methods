require "./my_enumerable"

describe "enumerable_methods" do
let(:arr) { [1, 2, 3, 4, 5] }

  describe "#my_each method" do 
    it "return the same results as #each method" do
      expect(arr.my_each {|x| p x, " -- " }).to eq(arr.each {|x| p x, " -- " })
    end
  end
  describe "#my_each_with_index method" do 
    it "return the same results as #each_with_index method" do
      expect(arr.my_each_with_index { |x, y| p "item: #{x}, index: #{y}" }).to eq(arr.each_with_index { |x, y| p "item: #{x}, index: #{y}" })
    end
  end
  describe "#my_select method" do 
    it "return the same results as #select method" do
      expect(arr.my_select {|x| x > 3 } ).to eq(arr.select {|x| x > 3 })
    end
  end




end


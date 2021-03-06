require './my_enumerable'

describe 'enumerable_methods' do
  let(:arr) { [1, 2, 3, 4, 5] }

  describe '#my_each method' do
    it 'return the same results as #each method' do
      expect(arr.my_each { |x| p x }).to eq(arr.each { |x| p x })
    end
  end
  describe '#my_each_with_index method' do
    it 'return the same results as #each_with_index method' do
      expect(arr.my_each_with_index { |x, y| p x, y }).to eq(arr.each_with_index { |x, y| p p x, y })
    end
  end
  describe '#my_select method' do
    it 'return the same results as #select method' do
      expect(arr.my_select { |x| x > 3 }).to eq(arr.select { |x| x > 3 })
    end
  end
  describe '#my_all?' do
    it 'return the same results as #all? method' do
      expect(arr.my_all?(1)).to eq(arr.all?(1))
    end
  end
  describe '#my_any?' do
    it 'return the same results as #any? method' do
      expect(arr.my_any?(1)).to eq(arr.any?(1))
    end
  end
  describe '#my_none?' do
    it 'return the same results as #none? method' do
      expect(arr.my_none?(1)).to eq(arr.none?(1))
    end
  end
  describe '#my_count' do
    it 'return the same results as #count method' do
      expect(arr.my_count).to eq(arr.count)
    end
  end
  describe '#my_map' do
    it 'return the same results as #map method' do
      expect(arr.my_map { |x| x * x }).to eq(arr.map { |x| x * x })
    end
  end
  describe '#my_inject' do
    it 'return the same results as #inject method' do
      expect(arr.my_inject(:+)).to eq(arr.inject(:+))
    end
  end
end

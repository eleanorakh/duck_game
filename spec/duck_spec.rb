require_relative '../duck'

describe Duck do
  describe '#set_default_health' do
    it 'sets default health' do
      duck = Duck.new
      duck.health = 42
      expect(duck.health).to eq 42
      duck.set_default_health
      expect(duck.health).to eq 50
    end
  end

  describe '#reduce_health' do
    it 'reduces health' do
      duck = Duck.new
      expect(duck.health).to eq 50
      duck.reduce_health
      expect(duck.health).to eq 49
    end
  end

  describe '#add_to_inventory' do
    it 'adds to inventory' do
      duck = Duck.new
      expect(duck.inventory).to eq []
      duck.add_to_inventory(:apple)
      expect(duck.inventory).to eq [:apple]
    end
  end

  describe '#remove_from_inventory' do
    it 'removes from inventory' do
      duck = Duck.new
      duck.instance_variable_set('@inventory', [:apple, :apple, :pear])
      expect(duck.inventory).to eq [:apple, :apple, :pear]
      duck.remove_from_inventory(:apple)
      expect(duck.inventory).to eq [:apple, :pear]
    end
  end
end

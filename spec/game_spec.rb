require 'rspec'
require_relative '../game'

describe Game do
  before do
    allow_any_instance_of(Game).to receive(:puts)
    allow_any_instance_of(Game).to receive(:print)
  end

  describe '#move' do
    it 'moves the duck when passed a valid bearing' do
      game = Game.new({[0,0] => Location.new, [0,1] => Location.new})
      expect(game.instance_variable_get('@current_location')).to eq [0,0]
      game.move('E')
      expect(game.instance_variable_get('@current_location')).to eq [0,1]
      game.move('W')
      expect(game.instance_variable_get('@current_location')).to eq [0,0]
    end
  end

  describe '#menu' do
    it 'moves when given the input "m E"' do
      game = Game.new({[0,0] => Location.new, [0,1] => Location.new})
      allow(game).to receive(:gets) { "m E" }
      game.menu
      expect(game.instance_variable_get('@current_location')).to eq [0,1]
    end

    it 'moves when given the input "mo E"' do
      game = Game.new({[0,0] => Location.new, [0,1] => Location.new})
      allow(game).to receive(:gets) { "mo E" }
      game.menu
      expect(game.instance_variable_get('@current_location')).to eq [0,1]
    end
  end
end

# spec/player_spec.rb

require './lib/player'

describe Player do
  describe 'choose_column' do
    it 'returns choosen column as integer' do
      player = Player.new('O')
      allow(player).to receive(:gets).and_return('1')
      expect(player.choose_column).to eql(1)
    end
    it 'returns first character as integer' do
      player = Player.new('X')
      allow(player).to receive(:gets).and_return('321')
      expect(player.choose_column).to eql(3)
    end
    it 'returns 0 if letters' do
      player = Player.new('A')
      allow(player).to receive(:gets).and_return('wleknc')
      expect(player.choose_column).to eql(0)
    end
    it 'returns 0 if negative numbers' do
      player = Player.new('O')
      allow(player).to receive(:gets).and_return('-1')
      expect(player.choose_column).to eql(0)
    end
  end
end

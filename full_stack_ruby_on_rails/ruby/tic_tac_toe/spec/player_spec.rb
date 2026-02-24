require_relative 'spec_helper'

RSpec.describe Player do
  subject(:player) { described_class.new('Alice', 'Z') }

  describe '#initialize' do
    it 'assigns name and symbol' do
      expect(player.name).to eq('Alice')
      expect(player.symbol).to eq('Z')
    end

    it 'defaults symbol to O' do
      p2 = described_class.new('Bob')
      expect(p2.symbol).to eq('O')
    end
  end

  describe '#get_move' do
    it 'reads input from STDIN and returns an integer' do
      allow($stdin).to receive(:gets).and_return("7\n")
      expect(player.get_move).to eq(7)
    end
  end
end

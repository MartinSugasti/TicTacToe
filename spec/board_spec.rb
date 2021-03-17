require_relative '../lib/board'

describe Board do
  describe '#winner' do
    subject(:board) { described_class.new('G', 'M') }

    context 'player one wins' do
      it 'returns player one identifier' do
        board.instance_variable_set(:@selections, { 'G' => [1, 3, 5, 9], 'M' => [2, 4, 6, 8] })
        expect(board.winner).to eq 'G'
      end
    end

    context 'player two wins' do
      it 'returns player two identifier' do
        board.instance_variable_set(:@selections, { 'G' => [1, 3, 5, 6], 'M' => [7, 8, 9] })
        expect(board.winner).to eq 'M'
      end
    end

    context 'no player wins' do
      context 'selections are empty' do
        it 'returns false' do
          board.instance_variable_set(:@selections, { 'G' => [], 'M' => [] })
          expect(board.winner).to be false
        end
      end

      context 'selections are not empty' do
        it 'returns false' do
          board.instance_variable_set(:@selections, { 'G' => [1, 3, 4, 6, 8], 'M' => [2, 5, 7, 9] })
          expect(board.winner).to be false
        end
      end
    end
  end

  describe '#draw?' do
    subject(:board) { described_class.new('G', 'M') }

    context 'when there still are locations available' do
      it 'returns false' do
        board.instance_variable_set(:@locations, [1, 2])
        expect(board.draw?).to be false
      end
    end

    context 'when there are not locations available' do
      it 'returns true' do
        board.instance_variable_set(:@locations, [])
        expect(board.draw?).to be true
      end
    end
  end

  describe '#valid_location?' do
    subject(:board) { described_class.new('G', 'M') }

    context 'when location is a valid string' do
      it 'returns true' do
        board.instance_variable_set(:@locations, [3, 4, 5])
        expect(board.valid_location?('5')).to be true
      end
    end

    context 'when location is a valid integer' do
      it 'returns true' do
        board.instance_variable_set(:@locations, [3, 4, 5])
        expect(board.valid_location?(5)).to be true
      end
    end

    context 'when location is valid but it is already taken' do
      it 'puts location already taken message and returns falsy' do
        board.instance_variable_set(:@locations, [1, 2, 3, 4, 5])
        expect(board).to receive(:puts).with('That place is already taken.')
        expect(board.valid_location?(7)).to be_falsy
      end
    end

    context 'when location is invalid' do
      it 'puts location not found message and returns falsy' do
        expect(board).to receive(:puts).with('Location not found.')
        expect(board.valid_location?('10')).to be_falsy
      end
    end
  end

  describe '#take_location' do
    subject(:board) { described_class.new('G', 'M') }

    it 'adds location to selections' do
      expect { board.take_location(1, 'G') }
        .to change { board.instance_variable_get(:@selections)['G'] }.to([1])
    end

    it 'removes location from locations' do
      board.instance_variable_set(:@locations, [1, 2, 3, 4, 5])
      board.take_location(1, 'G')
      expect(board.instance_variable_get(:@locations)).not_to include(1)
    end
  end

  describe '#print' do
    subject(:board) { described_class.new('G', 'M') }

    before do
      board.instance_variable_set(:@locations, [1, 2, 3, 4, 5])
      board.instance_variable_set(:@selections, { 'G' => [6, 7], 'M' => [8, 9] })
    end

    context 'location is already selected by any player' do
      it 'returns player identifier' do
        expect(board.print(8)).to eq('M')
      end
    end

    context 'location is not selected by any player' do
      it 'returns the location itself' do
        expect(board.print(2)).to eq(2)
      end
    end
  end
end

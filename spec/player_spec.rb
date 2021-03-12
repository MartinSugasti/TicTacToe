require_relative '../lib/player'

describe Player do
  describe '#choose_identifier' do
    subject(:player) { described_class.new }

    context 'when user inputs a correct value on the first attempt' do
      before do
        allow(player).to receive(:identifier_available?).and_return(true)
        allow(player).to receive(:identifier_is_valid?).and_return(true)
      end

      it 'ask for identifier twice' do
        asking_message = 'Choose an identifier:'
        expect(player).to receive(:puts).with(asking_message).once
        player.choose_identifier
      end
    end

    context 'when user inputs an incorrect value once, then a valid input' do
      before do
        allow(player).to receive(:identifier_available?).and_return(true, true)
        allow(player).to receive(:identifier_is_valid?).and_return(false, true)
      end

      it 'ask for identifier twice' do
        asking_message = 'Choose an identifier:'
        expect(player).to receive(:puts).with(asking_message).twice
        player.choose_identifier
      end
    end

    context 'when user inputs a correct value' do
      let(:valid_input) { 'M' }

      before do
        allow(player).to receive(:gets).and_return(valid_input)
        allow(player).to receive(:identifier_available?).and_return(true)
        allow(player).to receive(:identifier_is_valid?).and_return(true)
      end

      it 'push identifier to clarr variable identifiers' do
        player.choose_identifier
        expect(described_class.identifiers).to include(valid_input)
      end
    end
  end
end

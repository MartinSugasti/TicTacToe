require 'pry'

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

      it 'include identifier to class variable identifiers' do
        player.choose_identifier
        expect(described_class.identifiers).to include(valid_input)
      end
    end
  end

  describe '#identifier_available?' do
    subject(:player) { described_class.new }

    context 'identifier is avalilable' do
      before do
        player.instance_variable_set(:@identifier, 'M')
        described_class.instance_variable_set(:@identifiers, %w[G C])
      end

      it 'returns true' do
        expect(player.identifier_available?).to be(true)
      end

      it 'does not puts any message' do
        expect(player).not_to receive(:puts)
        player.identifier_available?
      end
    end

    context 'identifier is not avalilable' do
      before do
        player.instance_variable_set(:@identifier, 'M')
        described_class.instance_variable_set(:@identifiers, %w[M C])
      end

      it 'returns nil' do
        expect(player.identifier_available?).to be_nil
      end

      it 'puts unavailable identifier message' do
        expect(player).to receive(:puts).with(
          "#{player.instance_variable_get(:@identifier)} was already choosen as identifier."
        )
        player.identifier_available?
      end
    end
  end

  describe 'identifier_is_valid?' do
    subject(:player) { described_class.new }

    context 'identifier is valid' do
      before do
        player.instance_variable_set(:@identifier, 'M')
      end

      it 'returns true' do
        expect(player.identifier_is_valid?).to be(true)
      end

      it 'does not puts any message' do
        expect(player).not_to receive(:puts)
        player.identifier_is_valid?
      end
    end

    context 'identifier is invalid' do
      context 'identifier has more than one character' do
        before do
          player.instance_variable_set(:@identifier, 'Martin')
        end

        it 'returns falsy value' do
          expect(player.identifier_is_valid?).to be_falsy
        end

        it 'puts wrong identifier message' do
          expect(player).to receive(:puts).with('Identifier must has exactly one character.')
          player.identifier_is_valid?
        end
      end

      context 'identifier has more than one character' do
        before do
          player.instance_variable_set(:@identifier, '9')
        end

        it 'returns falsy value' do
          expect(player.identifier_is_valid?).to be_falsy
        end

        it 'puts wrong identifier message' do
          expect(player).to receive(:puts).with('Identifier can\'t be a number.')
          player.identifier_is_valid?
        end
      end

      context 'identifier is an empty string' do
        before do
          player.instance_variable_set(:@identifier, ' ')
        end

        it 'returns falsy value' do
          expect(player.identifier_is_valid?).to be_falsy
        end

        it 'puts wrong identifier message' do
          expect(player).to receive(:puts).with('Identifier can\'t be an empty string.')
          player.identifier_is_valid?
        end
      end
    end
  end
end

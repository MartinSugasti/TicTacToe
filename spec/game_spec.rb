require_relative '../lib/board'
require_relative '../lib/game'
require_relative '../lib/player'

describe Game do
  let(:player_one) { instance_double(Player, name: 'Guillermo', identifier: 'G') }
  let(:player_two) { instance_double(Player, name: 'Martin', identifier: 'M') }
  let(:board) { instance_double(Board) }

  before do
    allow(Player).to receive(:new).and_return(player_one, player_two)
    allow(player_one).to receive(:identify)
    allow(player_two).to receive(:identify)
    allow(Board).to receive(:new).and_return(board)
  end

  describe '#initialize' do
    it 'assign created players to instance variables' do
      game = described_class.new
      expect(game.instance_variable_get(:@player_one)).to be player_one
      expect(game.instance_variable_get(:@player_two)).to be player_two
    end

    it 'sends messages to Player and Board' do
      expect(Player).to receive(:new).twice
      expect(Board).to receive(:new).with(player_one.identifier, player_two.identifier).once
      described_class.new
    end

    it 'sends messages to the created Player instances' do
      expect(player_one).to receive(:identify)
      expect(player_two).to receive(:identify)
      described_class.new
    end
  end

  describe '#play' do
    context 'game ends in third round' do
      subject(:game) { Game.new }

      before do
        allow(game).to receive(:game_over?).and_return(false, false, false, true)
        allow(game).to receive(:print_result)
        allow(game).to receive(:play_turn)
      end

      it 'play three turns' do
        expect(game).to receive(:play_turn).exactly(3).times
        game.play
      end
    end
  end

  describe '#game_over?' do
    before do
      allow(board).to receive(:game_over?)
    end

    it 'sends message to board' do
      game = Game.new
      expect(board).to receive(:game_over?).once
      game.game_over?
    end
  end

  describe '#play_single_turn' do
    subject(:game) { Game.new }

    context 'player puts two invalid locations before a valid location' do
      before do
        allow(board).to receive(:print_board)
        allow(board).to receive(:valid_location?).and_return(false, false, true)
        allow(board).to receive(:take_location)
        allow(game).to receive(:puts)
        allow(game).to receive(:gets).and_return('')
      end

      it 'sends message to board and player' do
        expect(board).to receive(:print_board).exactly(3).times
        expect(board).to receive(:valid_location?).exactly(3).times
        expect(board).to receive(:take_location).once
        expect(player_one).to receive(:name).exactly(3).times
        expect(player_one).to receive(:identifier).exactly(4).times
        game.play_single_turn(player_one)
      end

      it 'asks player for identifier three times' do
        message = "#{player_one.name}, take an available location to "\
                  "place your identifier #{player_one.identifier}:"
        expect(game).to receive(:puts).with(message).exactly(3).times
        game.play_single_turn(player_one)
      end
    end
  end

  describe '#print_result' do
    subject(:game) { Game.new }

    context 'whatever the result is' do
      before do
        winner_identifier = [player_one.identifier, player_two.identifier, false].sample
        allow(board).to receive(:winner).and_return(winner_identifier)
        allow(game).to receive(:print_winner)
        allow(game).to receive(:print_draw)
      end

      it 'sends message to board' do
        expect(board).to receive(:winner).once
        game.print_result
      end
    end

    context 'there is a winner' do
      before do
        allow(board).to receive(:winner).and_return(player_one.identifier)
        allow(game).to receive(:print_winner)
      end

      it 'prints winner' do
        expect(game).to receive(:print_winner).with(player_one.identifier).once
        game.print_result
      end
    end

    context 'it\'s a draw' do
      before do
        allow(board).to receive(:winner).and_return(false)
        allow(game).to receive(:print_draw)
      end

      it 'prints draw' do
        expect(game).to receive(:print_draw).once
        game.print_result
      end
    end
  end

  describe '#print_winner' do
    subject(:game) { Game.new }

    context 'whoever the winner is' do
      before do
        allow(game).to receive(:puts)
      end

      it 'sends message to player one' do
        expect(player_one).to receive(:identifier)
        winner_identifier = [player_one.identifier, player_two.identifier].sample
        game.print_winner(winner_identifier)
      end
    end

    context 'player one wins' do
      it 'prints winner' do
        message = "#{player_one.name} is the winner!"
        expect(game).to receive(:puts).with(message).once
        game.print_winner(player_one.identifier)
      end
    end

    context 'player two wins' do
      it 'prints winner' do
        message = "#{player_two.name} is the winner!"
        expect(game).to receive(:puts).with(message).once
        game.print_winner(player_two.identifier)
      end
    end
  end
end

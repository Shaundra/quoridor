require_relative './player'
require_relative './board'

# Overall game class
class Quoridor
  attr_accessor :player_1, :player_2, :board, :current_player
  
  def initialize
    # Initialize board object.
    puts "Level of difficulty? Choose grid size 5 or 9."
    grid_size = gets.chomp.to_i
    @board = Board.new(grid_size)

    # # Initialize player instances.
    # puts "How many players? Type 2 or 4."
    # player_ct = gets.chomp.to_i # use this in later refactor
    
    puts "What's player 1's token? Choose X or O"
    player_1_token = gets.chomp.upcase
    player_2_token = player_1_token == "X" ? "O" : "X"
    puts "And player 2's token is #{player_2_token}"

    @player_1 = Player.new(player_1_token, [2, grid_size + 1], self.board)
    @player_2 = Player.new(player_2_token, [grid_size * 2, grid_size + 1], self.board)
    
    @current_player = @player_1

    self.board.display_board
  end

  # Play
  def play
    until game_over? 
      self.board.display_board

      puts "#{current_player}, it's your turn!"
      self.current_player.turn

      game_over? == true ? end_game : switch_player
    end
  end

  def switch_player
    self.current_player = other_player
  end

  def other_player
    self.current_player == player_1 ? player_2 : player_1
  end

  # Check for winner.
  def game_over?
    self.current_player.current_position[0] == other_player.baseline
  end

  def end_game
    puts "Congratulations, #{current_player}! You've won. Enjoy your victory."
  end

end

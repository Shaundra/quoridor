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
    # Loop until game over.
      # Render board.
      # Ask player for move & check that move is valid.
        # update @player_positions
      # Check if game is over, break if so.
      # Switch players. 
  end

  def switch_player
    self.current_player == player_1 ? player_2 : player_1
  end

  # Check for winner.
  def game_over?
    # Player has reached opponent's baseline.
  end

end

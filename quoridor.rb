# Overall game class
class Quoridor
  attr_accessor :player_1, :player_2, :board
  
  def initialize
    # Initialize board object.
    puts "Level of difficulty? Choose grid size 5 or 9."
    grid_size = gets.chomp.to_i
    @board = Board.new(grid_size)

    # Initialize player instances.
    puts "How many players? Type 2 or 4."
    player_ct = gets.chomp.to_i # use this in later refactor
    
    puts "What's player 1's token? Choose X or O"
    player_1_token = gets.chomp.upcase
    player_2_token = player_1_token == "X" ? "O" : "X"
    puts "And player 2's token is #{player_2_token}"

    @player_1 = Player.new(player_1_token, [0, grid_size - 1], self.board)
    @player_2 = Player.new(player_2_token, [grid_size * 2 - 2, grid_size - 1], self.board)
    
    
    self.board.display_board
  end

  # Method for a single turn
  # def turn(player)
  #   puts "Where would you like to move? forward, backward, left, or right?..."
  #   user_input = gets.chomp.downcase

  #   current_position = (player).current_position
  #   spaces_to_move = (player).set_move_direction(user_input, (player).baseline)
  #   new_position = [current_position, spaces_to_move].transpose.map { |x| x.sum }
  #   (player).move(new_position)

  #   board.display_board
  # end

  # Play
  def play
    # Loop until game over.
      # Render board.
      # Ask player for move & check that move is valid.
        # update @player_positions
      # Check if game is over, break if so.
      # Switch players. 
  end

  # Check for winner.
  def game_over?
    # Player has reached opponent's baseline.
  end

end

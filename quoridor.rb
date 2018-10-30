# Overall game class
class Quoridor
  attr_accessor :player_1, :player_2, :board
  
  # Initialize game.
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



class Board
  attr_accessor :board

  # Method to initialize a board of any grid size
  def initialize(grid_size)
    cell_ct = (grid_size * 2) - 1
    @board = Array.new(cell_ct){Array.new(cell_ct)}
  end

  # Method delegation / forwarding
  def [](index)
    @board[index]
  end

  # Method to render board of any grid size
  def display_board(board=@board)
    render_string = ""
    board.each_with_index do |arr, idx|
      if idx.even?
        arr.each_with_index do |elmt, index|
          if elmt.nil? == false
            render_string << " #{elmt} "
          elsif elmt.nil? && index.even?
            render_string << "   "
          elsif elmt.nil? && index.odd?
            render_string << "|"
          end
        end
        # render_string.chomp!("|")
        render_string << "\n"
      else
        arr.each_with_index do |elmt, index|
          if index.odd?
            render_string << "-"
          elsif elmt.nil? 
            render_string << "---" 
          else
            render_string << "-#{elmt}-"
          end
        end
        # render_string.chomp!("-") 
        render_string << "\n"
      end
    end
    puts render_string
  end

end


class Player
  attr_accessor :player_token, :fence_count, :current_position, :board, :baseline

  # Initialize 
  def initialize(player_token, initial_position, board)
    @player_token = player_token
    @current_position = initial_position
    @board = board
    @fence_count = 10
    @baseline = initial_position[0]

    # Move to starting position
    move(initial_position)
  end

  def move(new_position_coord)
    # remove 'from' position
    self.board[self.current_position[0]][self.current_position[1]] = nil
    
    # place in 'to' position
    self.board[new_position_coord[0]][new_position_coord[1]] = self.player_token

    # update current_position
    self.current_position = new_position_coord
  end

end

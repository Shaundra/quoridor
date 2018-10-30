# Overall game class
class Quoridor
#  attr_accessor :player_positions, :player_1, :player_2, :board
  attr_accessor :board
  
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

    @player_1 = Player.new(player_1_token)
    @player_2 = Player.new(player_2_token)
    
    # Initialize player positions. {token: [row, column]}
    @player_positions = {player_1_token => [0, grid_size - 1],
                          player_2_token => [grid_size * 2 - 2, grid_size - 1]
                        }
    
    # Players' starting positions on baselines
    @player_positions.each_pair do |key, value|
      self.board[value[0]][value[1]] = key.to_s
    end

    self.board.display_board
    # move(self.board, self.player_positions[:X][0], self.player_positions[:X][1], "X")
  end

  def get_player_positions(board, player_token)
    row = board.find_index { |arr| arr.include?(player_token) }
    index = board[row].find_index(player_token)
    self.player_positions[player_token.to_sym] = [row, index] 
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
  attr_accessor :player_token, :fence_count

  # Initialize 
  def initialize(player_token)
    @player_token = player_token
    @fence_count = 10
  end

  def current_position(board, player_token)
    @current_position = get_player_positions(board, player_token)
  end

  def move(board, row, index, player_token="X")
    # remove 'from' position
    board[current_position[0]][current_position[1]] = nil
    
    # place in 'to' position
    board[row][index] = player_token
  end

end

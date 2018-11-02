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
  def turn(player)
    puts "Where would you like to move? forward, backward, left, or right?..."
    user_input = gets.chomp.downcase

    current_position = (player).current_position
    spaces_to_move = (player).set_move_direction(user_input, (player).baseline)
    new_position = [current_position, spaces_to_move].transpose.map { |x| x.sum }
    (player).move(new_position)

    board.display_board
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
  attr_accessor :board, :cell_ct, :grid_size

  # Method to initialize a board of any grid size
  def initialize(grid_size)
    @grid_size = grid_size
    @cell_ct = (grid_size * 2) - 1
    @board = Array.new(cell_ct){Array.new(cell_ct)}

    populate_board_guide(board)
  end

  # Method delegation / forwarding
  def [](index)
    @board[index]
  end

  def populate_board_guide(board = @board)
    board.each_with_index do |x, idx|
      if idx == 0
        x.each_with_index { |elmt, idx| idx.even? && idx > 1 ? x[idx] = " #{idx - 2} " : x[idx] = "#{idx - 2}"}
        x[0] = "   "
        x[1] = " "
      elsif idx == 1
        x.map! { |elmt| elmt = " " }
        x[0] = "   "
      else
        x[0] = " #{idx - 2} "
        x[1] = ":"
      end
    end
  end

  # Method to render board of any grid size
  def display_board(board = @board)
    render_string = ""
    board.each_with_index do |arr, idx|
      if idx.even?
        arr.each_with_index do |elmt, index|
          if elmt.nil? == false
            render_string << "#{elmt}"
          elsif elmt.nil? && index.even?
            render_string << "   "
          elsif elmt.nil? && index.odd?
            render_string << "|"
          end
        end
        render_string << "\n"
      else
        arr.each_with_index do |elmt, index|
          if index < 2
            render_string << " #{elmt} " 
          elsif (index.odd? and elmt.nil? == false)
            render_string << "#{elmt}"
          elsif index.odd? and elmt.nil?
            render_string << "-"
          elsif elmt.nil? 
            render_string << "---" 
          else
            render_string << "-#{elmt}-"
          end
        end
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

  def set_move_direction(direction, baseline)
    add_to_coordinates = case 
      when (baseline == 0 && direction == "forward") || (baseline > 0 && direction == "backward")
        [2, 0]
      when (baseline == 0 && direction == "backward") || (baseline > 0 && direction = "forward")
        [-2, 0]
      when (baseline == 0 && direction == "left") || (baseline > 0 && direction == "right")
        [0, 2]
      when (baseline == 0 && direction == "right") || (baseline > 0 && direction =- "left")
        [0, -2]
      end      
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

class Player
  attr_accessor :player_token, :fence_count, :current_position, :board, :baseline

  def initialize(player_token, initial_position, board)
    @player_token = player_token
    @current_position = initial_position
    @board = board
    @fence_count = 10
    @baseline = initial_position[0]

    # Move to starting position
    move_pawn(initial_position)
  end

  def to_s
    "Player #{self.player_token} (Fence count: #{self.fence_count})"
  end

  def turn(turn_type = ask_turn_type)
    if turn_type == "pawn"
      move_coords = board.new_position_to_coords(get_new_position)
      valid_move_adjacent_to_current_and_not_blocked = board.valid_pawn_move?(move_coords) && 
                                                    adjacent_to_current?(move_coords) &&
                                                    !(blocked_by_fence?(move_coords))
      if valid_move_adjacent_to_current_and_not_blocked
        move_pawn(move_coords)
      else
        puts "Invalid move. Try again!"
        turn(turn_type)
      end
    elsif turn_type == "fence"
      move_coords = board.new_position_to_coords(get_new_position)
      if board.valid_fence_move?(move_coords)
        place_fence(move_coords)
      else
        puts "Invalid placement. Try again!"
        turn(turn_type)
      end
    end
  end

  def ask_turn_type
    if self.fence_count > 0
      puts "Would you like to move your pawn or place a fence? Type pawn or fence."
      user_input = gets.strip.downcase

      if %w[pawn fence].member?(user_input) == false
        puts "Invalid move type."
        ask_turn_type
      else
        user_input
      end
    else
      puts "You don't have any fences. Move your pawn."
      "pawn"
    end
  end

  def get_new_position
    puts "Where would you like to move? Use the board guide to choose row, column coordinates. Ex. 2, 4"
    user_input = gets.strip.split(",").map { |x| x.to_i }

    if user_input.is_a?(Array) && user_input.size == 2
      user_input
    else
      puts "Invalid form. Try again."
      get_new_position
    end
  end

  def adjacent_to_current?(coords)
    current = self.current_position

    (current[0] == coords[0] && (current[1] - coords[1]).abs == 2) ||
    (current[1] == coords[1] && (current[0] - coords[0]).abs == 2)
  end

  def blocked_by_fence?(coords)
    current = self.current_position

    if (current[0] == coords[0] && board[current[0]][(current[1] + coords[1]) / 2] == "*") ||
       (current[1] == coords[1] && board[(current[0] + coords[0]) / 2][current[1]] == "*")
       true
    end
  end

  def move_pawn(new_position_coord)
    # Remove 'from' position
    self.board[self.current_position[0]][self.current_position[1]] = nil
    
    # Place in 'to' position
    self.board[new_position_coord[0]][new_position_coord[1]] = " #{self.player_token} "

    # Update current_position
    self.current_position = new_position_coord
  end

  def place_fence(new_position_coord)
    self.board[new_position_coord[0]][new_position_coord[1]] = "*"
    self.fence_count -= 1
  end
end



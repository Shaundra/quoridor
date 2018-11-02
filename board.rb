class Board
  attr_accessor :board, :cell_ct, :grid_size

  # Initialize a board of any grid size
  def initialize(grid_size)
    @grid_size = grid_size
    @cell_ct = (grid_size * 2) + 1
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
        x.each_with_index do |elmt, idx| 
          if idx.even? && idx > 1 
            x[idx] = " #{idx - 2} "
          else 
            x[idx] = "#{idx - 2}"
          end
        end
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
          if index < 2 || (index.odd? && elmt.nil? == false)
            render_string << "#{elmt}" 
          elsif index.odd? && elmt.nil?
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

  def valid_pawn_move?(coords)
    if on_the_board?(coords) &&
      not_a_boundary?(coords) &&
      not_a_guide_cell?(coords) &&
      position_open?(coords)
      # !(blocked_by_fence?(coords))
      true
    end
  end

  def new_position_to_coords(new_position)
    new_position.map { |x| x + 2 }
  end

  def not_a_boundary?(coords)
    coords.all? { |coord| coord.even? }
  end

  def not_a_guide_cell?(coords)
    coords.all? { |x| x != 0 && x != 1 }
  end

  def on_the_board?(coords)
    coords.all? { |coord| coord < self.cell_ct - 1 }
  end

  def position_open?(coords)
    board[coords[0]][coords[1]].nil?
  end

  def blocked_by_fence?
  end
end






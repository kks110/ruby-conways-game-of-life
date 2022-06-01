require './cell'

class Game
  attr_accessor :board

  def initialize(row_count: 40, column_count: 80, alive_cells: [])
    @board = build_board(row_count: row_count, column_count: column_count, alive_cells: alive_cells)
  end

  def tick
    row_limit = @board.count - 1

    @board.each do |row|
      column_limit = row.count - 1
      row.each do |cell|
        location = cell.location
        row_num = location[0]
        column_num = location[1]

        neighbours = []
        neighbours << @board[row_num - 1][column_num - 1] if row_num.positive? && column_num.positive?
        neighbours << @board[row_num - 1][column_num] if row_num.positive?
        neighbours << @board[row_num - 1][column_num + 1] if row_num.positive? && column_num < column_limit
        neighbours << @board[row_num][column_num - 1] if column_num.positive?
        neighbours << @board[row_num][column_num + 1] if column_num < column_limit
        neighbours << @board[row_num + 1][column_num - 1] if column_num.positive? && row_num < row_limit
        neighbours << @board[row_num + 1][column_num] if row_num < row_limit
        neighbours << @board[row_num + 1][column_num + 1] if column_num < column_limit && row_num < row_limit

        count = 0
        neighbours.each do |neighbour|
          count += 1 if neighbour&.alive
        end

        cell.tick(alive_count: count)
      end
    end
  end

  def update
    @board.each do |row|
      row.each(&:update)
    end
  end

  def draw
    @board.each do |row|
      row.each(&:draw)
      puts
    end
  end

  private

  def build_board(row_count:, column_count:, alive_cells:)
    board = []

    row_count.times do |x|
      row = []
      column_count.times do |y|
        alive = alive_cells.include?([x,y])
        row << Cell.new(x_pos: x, y_pos: y, alive: alive)
      end
      board << row
    end

    board
  end
end

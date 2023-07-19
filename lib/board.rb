# frozen_string_literal: true

# the board to be played on
class Board
  attr_reader :board

  def initialize
    @board = create_board
  end

  def show_board
    @board.each { |row| p row }
  end

  def create_board
    Array.new(4) { Array.new(4) }
  end

  def put_token(col, token = '')
    return unless column_in_board? col

    return false if column_full? col

    row = next_row_in_col? col
    @board[row][col] = token
    true
  end

  def next_row_in_col?(col)
    3.downto(0).each { |i| return i if @board[i][col].nil? }
    nil
  end

  def column_full?(col)
    @board.all? { |row| !row[col].nil? }
  end

  def col_uniq?(col)
    return @board.reduce([]) { |result, row| result << row[col] }.uniq.size == 1 if column_full? col

    false
  end

  def row_uniq?(row)
    return false unless column_in_board?(row)

    uniqs = @board[row].uniq
    uniqs.size == 1 && !uniqs[0].nil?
  end

  def diag_uniq?
    diag1 = @board.map(&:reverse).each_with_index.reduce([]) { |array, (row, index)| array << row[index] }.uniq
    diag2 = @board.each_with_index.reduce([]) { |array, (row, index)| array << row[index] }.uniq
    return diag1[0].nil? ? false : true if diag1.size == 1
    return diag2[0].nil? ? false : true if diag2.size == 1

    false
  end

  def column_in_board?(col)
    col.between?(0, 3)
  end

  def evaluate
    evaluations = []
    3.downto(0).each do |index|
      evaluations << col_uniq?(index)
      evaluations << row_uniq?(index)
    end
    evaluations << diag_uniq?
    evaluations.include? true
  end
end

# spec/board_spec.rb

require './lib/board'

describe Board do
  describe '#create_board' do
    it 'returns the board' do
      expect(Board.new.create_board).to_not eql(nil)
    end
    it 'has 4 columns' do
      board = Board.new
      expect(board.create_board.length).to eql(4)
    end
    it 'has 4 rows' do
      board = Board.new
      expect(board.create_board[0].length).to eql(4)
    end
    it 'return 4x4 matrix' do
      expect(Board.new.create_board).to eql(Array.new(4) { Array.new(4) })
    end
  end
end

describe Board do
  describe '#put_token' do
    it 'returns nil if column out of board' do
      board = Board.new
      expect(board.put_token(4)).to eql(nil)
    end
    it 'returns nil if column is negative' do
      board = Board.new
      expect(board.put_token(-4)).to eql(nil)
    end
    it 'returns true if column is in board' do
      board = Board.new
      expect(board.put_token(0)).to eql(true)
    end
    it 'returns true if column is in board' do
      board = Board.new
      expect(board.put_token(3)).to eql(true)
    end
    it 'returns false if column is full' do
      board = Board.new
      4.times { board.put_token(0)}
      expect(board.put_token(0)).to eql(false)
    end
    it 'places token correctly on the bottom' do
      board = Board.new
      expected_matrix = Array.new(4) { Array.new(4) }
      expected_matrix[3][1] = 'O'
      board.put_token(1, 'O')
      expect(board.board).to eql(expected_matrix)
    end
    it 'places 2 token correctly on top of another' do
      board = Board.new
      expected_matrix = Array.new(4) { Array.new(4) }
      expected_matrix[2][1] = 'X'
      expected_matrix[3][1] = 'O'
      board.put_token(1, 'O')
      board.put_token(1, 'X')
      expect(board.board).to eql(expected_matrix)
    end
    it 'places 3 token correctly on top of another' do
      board = Board.new
      expected_matrix = Array.new(4) { Array.new(4) }
      expected_matrix[1][2] = 'O'
      expected_matrix[2][2] = 'X'
      expected_matrix[3][2] = 'O'
      'OXO'.split('').each { |token| board.put_token(2, token) }
      expect(board.board).to eql(expected_matrix)
    end
    it 'places 4 token correctly on top of another' do
      board = Board.new
      expected_matrix = Array.new(4) { Array.new(4) }
      expected_matrix[0][3] = 'O'
      expected_matrix[1][3] = 'X'
      expected_matrix[2][3] = 'O'
      expected_matrix[3][3] = 'X'
      'XOXO'.split('').each { |token| board.put_token(3, token) }
      expect(board.board).to eql(expected_matrix)
    end
    it 'places 2 token correctly besides another' do
      board = Board.new
      expected_matrix = Array.new(4) { Array.new(4) }
      expected_matrix[3][1] = 'O'
      expected_matrix[3][2] = 'X'
      board.put_token(1, 'O')
      board.put_token(2, 'X')
      expect(board.board).to eql(expected_matrix)
    end
  end
end

describe Board do
  describe '#column_full?' do
    it 'returns false if column not full' do
      board = Board.new
      expect(board.column_full?(0)).to eql(false)
    end
    it 'returns false if column has 1 token' do
      board = Board.new
      board.put_token(0)
      expect(board.column_full?(0)).to eql(false)
    end
    it 'returns false if column has 2 token' do
      board = Board.new
      2.times { |i| board.put_token(0)}
      expect(board.column_full?(0)).to eql(false)
    end
    it 'returns false if column has 3 token' do
      board = Board.new
      3.times { |i| board.put_token(0)}
      expect(board.column_full?(0)).to eql(false)
    end
    it 'returns true if column has 4 token' do
      board = Board.new
      4.times { |i| board.put_token(0)}
      expect(board.column_full?(0)).to eql(true)
    end
  end
end

describe Board do
  describe '#column_in_board?' do
    it 'returns false if 4' do
      expect(Board.new.column_in_board?(4)).to eql(false)
    end
    it 'returns false if -1' do
      expect(Board.new.column_in_board?(-1)).to eql(false)
    end
    it 'returns true if 0' do
      expect(Board.new.column_in_board?(0)).to eql(true)
    end
    it 'returns true if 3' do
      expect(Board.new.column_in_board?(3)).to eql(true)
    end
  end
end

describe Board do
  describe '#next_row_in_col?' do
    it 'return 3 if no token in column' do
      expect(Board.new.next_row_in_col?(2)).to eql(3)
    end
    it 'return 2 if 1 token in column' do
      board = Board.new
      board.put_token(0, 'X')
      expect(board.next_row_in_col?(0)).to eql(2)
    end
    it 'return 1 if 2 token in column' do
      board = Board.new
      2.times { board.put_token(1, 'O') }
      expect(board.next_row_in_col?(1)).to eql(1)
    end
    it 'return 0 if 3 token in column' do
      board = Board.new
      3.times { board.put_token(3, 'O') }
      expect(board.next_row_in_col?(3)).to eql(0)
    end
    it 'return nil if 4 token in column' do
      board = Board.new
      4.times { board.put_token(2, 'X') }
      expect(board.next_row_in_col?(2)).to eql(nil)
    end
  end
end

describe Board do
  describe '#col_uniq?' do
    it 'return true if all token in col are same' do
      board = Board.new
      'OOOO'.split('').each { |token| board.put_token(3, token) }
      expect(board.col_uniq?(3)).to eql(true)
    end
    it 'return true if all token in col are same' do
      board = Board.new
      'XXXX'.split('').each { |token| board.put_token(2, token) }
      expect(board.col_uniq?(2)).to eql(true)
    end
    it 'return false if token in col are different' do
      board = Board.new
      'OXOX'.split('').each { |token| board.put_token(1, token) }
      expect(board.col_uniq?(1)).to eql(false)
    end
    it 'return false if col not full' do
      board = Board.new
      'OX'.split('').each { |token| board.put_token(0, token) }
      expect(board.col_uniq?(0)).to eql(false)
    end
    it 'return false if col empty' do
      board = Board.new
      expect(board.col_uniq?(0)).to eql(false)
    end
    it 'return false if col out of board' do
      board = Board.new
      expect(board.col_uniq?(10)).to eql(false)
    end
  end
end

describe Board do
  describe '#row_uniq?' do
    it 'return true if all token in row are same' do
      board = Board.new
      'OOOO'.split('').each_with_index { |token, index| board.put_token(index, token) }
      expect(board.row_uniq?(3)).to eql(true)
    end
    it 'return true if all token in row are same' do
      board = Board.new
      'XXXX'.split('').each_with_index { |token, index| board.put_token(index, token) }
      expect(board.row_uniq?(3)).to eql(true)
    end
    it 'return false if token in row are different' do
      board = Board.new
      'OXOX'.split('').each_with_index { |token, index| board.put_token(index, token) }
      expect(board.row_uniq?(3)).to eql(false)
    end
    it 'return false if row not full' do
      board = Board.new
      'OX'.split('').each_with_index { |token, index| board.put_token(index, token) }
      expect(board.row_uniq?(3)).to eql(false)
    end
    it 'return false if row empty' do
      board = Board.new
      expect(board.row_uniq?(2)).to eql(false)
    end
    it 'return false if row out of board' do
      board = Board.new
      expect(board.row_uniq?(18)).to eql(false)
    end
  end
end

describe Board do
  describe '#diag_uniq?' do
    it 'return true if eather diagonal has all same token' do
      board = Board.new
      'OXXX'.split('').each_with_index { |token, index| board.put_token(index, token) }
      'XOXX'.split('').each_with_index { |token, index| board.put_token(index, token) }
      'XXOX'.split('').each_with_index { |token, index| board.put_token(index, token) }
      'XXXO'.split('').each_with_index { |token, index| board.put_token(index, token) }
      expect(board.diag_uniq?).to eql(true)
    end
    it 'return false if eather diagonal has not all same token' do
      board = Board.new
      'OXXX'.split('').each_with_index { |token, index| board.put_token(index, token) }
      'XOXX'.split('').each_with_index { |token, index| board.put_token(index, token) }
      'XXOX'.split('').each_with_index { |token, index| board.put_token(index, token) }
      expect(board.diag_uniq?).to eql(false)
    end
    it 'return false if board has no token' do
      expect(Board.new.diag_uniq?).to eql(false)
    end

  end
end

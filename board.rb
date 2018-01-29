require_relative 'pieces'

class Board
    attr_reader :rows

    def initialize(fill_board = true)
        @sentinel = NullPiece.instance
        make_starting_grid(fill_board)
    end

    def [](position)
        raise 'Invalid position' unless valid_position?(position)

        row, col = position
        @rows[row][col]
    end

    def []=(position, piece)
        raise 'Invalid position' unless valid_position?(position)

        row, col = position
        @rows[row][col] = piece
    end

    def add_piece(piece, position)
        raise 'Position occupied' unless self[position].empty?

        self[position] = piece
    end

    def empty?(position)
        self[position].empty?
    end

    def move_piece(start_pos, end_pos)
        raise 'No piece @ start_pos' if empty?(start_pos)

        piece = self[start_pos]

        self[end_pos] = piece
        self[start_pos] = sentinel
        piece.position = end_pos

        nil
    end

    def valid_position?(position)
        position.all? { |coord| coord.between?(0, 7) }
    end

    private
    attr_reader :sentinel

    def make_starting_grid(fill_board)
        @rows = Array.new(8) { Array.new(8, sentinel) }
        return unless fill_board

        %i(white black).each do |color|
            fill_back_row(color)
            fill_pawns(color)
        end
    end

    def fill_back_row(color)
        back_pieces = [Rook, Knight, Bishop, Queen, King, Bishop, Knight, Rook]

        i = color === :white ? 7 : 0
        back_pieces.each_with_index do |piece, j|
            piece.new(color, self, [i, j])
        end
    end

    def fill_pawns(color)
        i = color == :white ? 6 : 1
        8.times { |j| Pawn.new(color, self, [i, j]) }
    end

end
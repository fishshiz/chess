class Piece
    attr_reader :color, :board
    attr_accessor :position
    def initialize(color, board, position)
        raise 'color is not black or white' unless %i(white black).include?(color)
        raise 'position error' unless board.valid_position?(position)

        @color, @board, @position = color, board, position

        board.add_piece(self, position)
    end

    def empty?
        self.is_a?(NullPiece) ? true : false
    end
    
end
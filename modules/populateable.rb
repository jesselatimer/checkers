module Populateable

  def populate
    grid.each_with_index do |row, i|
      row.each_with_index do |tile, j|
        if (i + j) % 2 == 0 && i < 3
          tile = Piece.new(:red)
        elsif (i + j) % 2 > 0 && i > 4
          tile = Piece.new(:black)
        end
      end
    end
  end

end

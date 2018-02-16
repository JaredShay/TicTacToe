require_relative './element'

class GameBoard
  include Element

  SELECTOR =
<<-eos
┌---┐
|   |
└---┘
eos

  BOARD =
<<-eos
      |       |
      |       |
      |       |
------+-------+-------
      |       |
      |       |
      |       |
------+-------+-------
      |       |
      |       |
      |       |
eos

  def initialize
    paint
    @render   = true
  end

  def render?
    true
  end

  def paint
    @buffer = []

    @buffer << [0, 7,  '|']
    @buffer << [0, 15, '|']
    @buffer << [1, 7,  '|']
    @buffer << [1, 15, '|']
    @buffer << [2, 7,  '|']
    @buffer << [2, 15, '|']

    @buffer << [3, 7, '+']
    @buffer << [3, 15, '+']

    @buffer << [4, 7,  '|']
    @buffer << [4, 15, '|']
    @buffer << [5, 7,  '|']
    @buffer << [5, 15, '|']
    @buffer << [6, 7,  '|']
    @buffer << [6, 15, '|']

    @buffer << [7, 7, '+']
    @buffer << [7, 15, '+']

    @buffer << [8, 7,  '|']
    @buffer << [8, 15, '|']
    @buffer << [9, 7,  '|']
    @buffer << [9, 15,  '|']
    @buffer << [10, 7, '|']
    @buffer << [10, 15, '|']

    (0..6).to_a.each do |n|
      @buffer << [3, n, '-']
      @buffer << [7, n, '-']
    end

    (8..14).to_a.each do |n|
      @buffer << [3, n, '-']
      @buffer << [7, n, '-']
    end

    (16..21).to_a.each do |n|
      @buffer << [3, n, '-']
      @buffer << [7, n, '-']
    end
  end
end

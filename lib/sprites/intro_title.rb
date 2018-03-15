require_relative '../color'

module Sprites
  extend Color
  X_INTRO_TITLE = <<-X_INTRO_TITLE
XXXXXXXXXXXXXXXXXXXXXXX  XXXX                      XXXXXXXXXXXXXXXXXXXXXXX                                   XXXXXXXXXXXXXXXXXXXXXXX
X.....................X X....X                     X.....................X                                   X.....................X
X.....................X  XXXX                      X.....................X                                   X.....................X
X.....XX.......XX.....X                            X.....XX.......XX.....X                                   X.....XX.......XX.....X
XXXXXX  X.....X  XXXXXXXXXXXXX     XXXXXXXXXXXXXXXXXXXXXX  X.....X  XXXXXXXXXXXXXXXXXXX      XXXXXXXXXXXXXXXXXXXXXX  X.....X  XXXXXXXXXXXXXXXXX       XXXXXXXXXXXX
        X.....X        X.....X   XX...............X        X.....X        X............X   XX...............X        X.....X      XX...........XX   XX............XX
        X.....X         X....X  X.................X        X.....X        XXXXXXXXX.....X X.................X        X.....X     X...............X X......XXXXX.....XX
        X.....X         X....X X.......XXXXXX.....X        X.....X                 X....XX.......XXXXXX.....X        X.....X     X.....XXXXX.....XX......X     X.....X
        X.....X         X....X X......X     XXXXXXX        X.....X          XXXXXXX.....XX......X     XXXXXXX        X.....X     X....X     X....XX.......XXXXX......X
        X.....X         X....X X.....X                     X.....X        XX............XX.....X                     X.....X     X....X     X....XX.................X
        X.....X         X....X X.....X                     X.....X       X....XXXX......XX.....X                     X.....X     X....X     X....XX......XXXXXXXXXXX
        X.....X         X....X X......X     XXXXXXX        X.....X      X....X    X.....XX......X     XXXXXXX        X.....X     X....X     X....XX.......X
      XX.......XX      X......XX.......XXXXXX.....X      XX.......XX    X....X    X.....XX.......XXXXXX.....X      XX.......XX   X.....XXXXX.....XX........X
      X.........X      X......X X.................X      X.........X    X.....XXXX......X X.................X      X.........X   X...............X X........XXXXXXXX
      X.........X      X......X  XX...............X      X.........X     X..........XX...X XX...............X      X.........X    XX...........XX   XX.............X
      XXXXXXXXXXX      XXXXXXXX    XXXXXXXXXXXXXXXX      XXXXXXXXXXX      XXXXXXXXXX  XXXX   XXXXXXXXXXXXXXXX      XXXXXXXXXXX      XXXXXXXXXXX       XXXXXXXXXXXXXX
X_INTRO_TITLE

  INTRO_TITLE = X_INTRO_TITLE.split("\n").each_with_index.each_with_object([]) do |line_i, obj|
    line, row = line_i
    line.split('').each_with_index do |el, col|
      next if el == ' '

      x = if el == 'X'
            color(' ', :black, :black)
          else
            color(' ', :green, :green)
          end

      obj[row] ||= []
      obj[row][col] = x
    end
  end
end

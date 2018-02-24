require_relative './color'

class Game
  include Color

  X = <<-eos
                        //           //
                       //           //
                      //           //
                     //           //
         -----------//-----------//-----------
                   //           //
                  //           //
                 //           //
                //           //
    -----------//-----------//-----------
              //           //
             //           //
            //           //
           //           //
  eos

  attr_reader :buffer
  def initialize
    paint
  end

  def tick(state)
  end

  def render?
    false
  end

  def paint
    @buffer = []

    X.split("\n").each_with_index do |row, ri|
      row.split('').each_with_index do |el, ci|
        if el == "/" || el == "-"
          @buffer << [ri, ci, color(el, :blue, :black)]
        end
      end
    end
  end

end

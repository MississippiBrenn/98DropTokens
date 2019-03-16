require 'pry'


class Game
  def initialize
    @board = GameSetup.new.board
  end

  def display_board
    @board.each do |row|
      row.each do |cell|
        print ("#{cell.to_s}")
      end
      puts
    end
  end


  def play
    @currentPlayer = "2"
    @plays = []
    loop do

      # draw()
      @userInput = gets.chomp.downcase
      if @userInput == "exit"
        system "clear" or system "cls"
        exit
      elsif @userInput == "get"
        puts "get stuff"
      elsif @userInput == "board"
        display_board
      elsif @userInput.include? "put"
        @currentPlayer=="1" ? @currentPlayer="2" : @currentPlayer= "1"
        column = @userInput[-1].to_i-1
        dropColumn(column)
        @plays<<[column]
      elsif @userInput == "win"
        hasWon()
      end
    end
  end

  def dropColumn(column)
    if @board[3][column] == 0
      @board[3][column] = @currentPlayer
      puts("OK")
    elsif @board[2][column] == 0
      @board[2][column] = @currentPlayer
      puts("OK")
    elsif @board[1][column] == 0
      @board[1][column] = @currentPlayer
      puts("OK")
    elsif @board[0][column] == 0
      @board[0][column] = @currentPlayer
      puts("OK")
    else
      puts("ERROR")
    end
  end

  def hasWon
    @winningLength = 4-1
    rowIndex = 0
    @board.each do |row|
      columnIndex = 0
      row.each do |cell|
        if cell == @currentPlayer
          if columnIndex === 0 && rowIndex === 0
            if leftDiagonalWin(rowIndex,columnIndex)
              puts('WIN')
            end
          end

          if columnIndex >= @winningLength && rowIndex >= @winningLength
            puts ("indiagonal win")
            if rightDiagonalWin(rowIndex,columnIndex)
              puts('WIN')
            end
          end


          if rowIndex >= @winningLength
            if verticalWin(columnIndex)
              puts('WIN')
            end

          end
          if columnIndex >= @winningLength
            if horizontalWin(rowIndex)
              puts('WIN')
            end
          end
        end
        puts(" #{rowIndex},#{columnIndex},")
        columnIndex+=1
      end
      rowIndex+=1
    end
  end

  def leftDiagonalWin(rowIndex, columnIndex)
    i =  0

    while i > @board.length
      if @board[rowIndex+i][columnIndex+i] != @currentPlayer.to_s
        return false
      end
      i += 1
    end
    return true
  end

  def rightDiagonalWin(rowIndex, columnIndex)
    i = @board.length

    while i > 0
      if @board[rowIndex-i][columnIndex-i] != @currentPlayer.to_s
        return false
      end
      i -= 1
    end
    return true
  end

  def horizontalWin(rowIndex)
    i = @board.length[0]
    while i > 0
      if @board[rowIndex][i] != @currentPlayer.to_s
        return false
      end
      i -=1
    end
    return true
  end


  def verticalWin(columnIndex)
    i = @board.length-1
    while i > 0
      if @board[i][columnIndex] != @currentPlayer.to_s
        return false
      end
      i -=1
    end
    return true
  end


  # def draw
  #   if @plays. = @board.length * @board[0].length
  #     puts ("DRAW")
  #   end
  # end
end

class GameSetup
  attr_reader :board
  def initialize
    @board = [[0,0,0,0],[0,0,0,0],[0,0,0,0],[0,0,0,0]]
  end
end



new_game = Game.new

new_game.play

# chose to use pry as this functions as interface
# also looked into usign option parser of Thor
require 'pry'


class Game
  def initialize
    @board = GameSetup.new.board
  end

  def display_board
    @board.each_with_index do |row, rowIndex|
      print("| ")
      row.each_with_index do |cell, index|
        print ("#{cell.to_s} ")
      end
      puts
    end
    puts("+--------")
    puts("  1 2 3 4")
  end

  # begins the game and continues until exit is called by user
  def play
    @currentPlayer = "2"
    @plays = []
    loop do
      hasWon()
      draw()
      @userInput = gets.chomp.downcase
      if @userInput == "exit"
        exit
      elsif @userInput == "get"
        @plays.each do |play|
          puts ("#{play}")
        end
      elsif @userInput == "board"
        display_board
      elsif @userInput.include? "put "
        @currentPlayer=="1" ? @currentPlayer="2" : @currentPlayer= "1"
        if @userInput.to_i.to_s == @userInput
          column = @userInput[-1].to_i-1
          dropColumn(column)
          @plays<<column
        end
      else
        puts "Please enter valid command."
        puts "BOARD - prints board"
        puts "PUT <column> - places token in column(eg. PUT 4)"
        puts "GET - returns columns played"
        puts "EXIT - exits program"
      end
    end
  end

  # places token based on availble squares in column, in asc order
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

  # determines if there is a connecting line of 4
  # chose to keep this responsive to changes in winningLength and board size
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

          if columnIndex >= @winningLength && rowIndex === 0
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
        columnIndex+=1
      end
      rowIndex+=1
    end
  end

  def leftDiagonalWin(rowIndex, columnIndex)
    i =  0
    while i <= @board.length-1
      if @board[rowIndex+i][columnIndex+i] != @currentPlayer.to_s
        return false
      end
      i += 1
    end
    return true
  end

  def rightDiagonalWin(rowIndex, columnIndex)
    i = 0
    while i <= @board.length-1
      if @board[rowIndex+i][columnIndex-i] != @currentPlayer.to_s
        return false
      end
      i += 1
    end
    return true
  end

  def horizontalWin(rowIndex)
    i = @board.length[0]
    while i >= 0
      if @board[rowIndex][i] != @currentPlayer.to_s
        return false
      end
      i -=1
    end
    return true
  end


  def verticalWin(columnIndex)
    i = @board.length-1
    while i >= 0
      if @board[i][columnIndex] != @currentPlayer.to_s
        return false
      end
      i -=1
    end
    return true
  end

  # if all plays have taken place and no win has happened, it is a draw
  def draw
    numberOfPlays = @plays.count
    boardSpaces = @board.length * @board[0].length
    if numberOfPlays == boardSpaces
      puts ("DRAW")
    end
  end
end

# sets up board
class GameSetup
  attr_reader :board
  def initialize
    @board = [[0,0,0,0],[0,0,0,0],[0,0,0,0],[0,0,0,0]]
  end
end


# starts program within file
new_game = Game.new

new_game.play

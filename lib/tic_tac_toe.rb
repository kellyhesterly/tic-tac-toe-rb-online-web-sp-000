WIN_COMBINATIONS  = [
  [0,1,2],
  [3,4,5],
  [6,7,8],
  [0,3,6],
  [1,4,7],
  [2,5,8],
  [0,4,8],
  [2,4,6]
]


def display_board(board)
  puts " #{board[0]} | #{board[1]} | #{board[2]} "
  puts "-----------"
  puts " #{board[3]} | #{board[4]} | #{board[5]} "
  puts "-----------"
  puts " #{board[6]} | #{board[7]} | #{board[8]} "
end

def input_to_index(input)
  input.to_i - 1
end

def move(board, index, token)
  board[index] = token
end

def position_taken?(board, index)
  board[index] == "X" || board[index] == "O"
end

def valid_move?(board, index)
  index.between?(0,8) && !position_taken?(board, index)
end

def turn_count(board)
  counter = 0
    board.count do |element|
    if element == "X" || element == "O"
    counter += 1
    end
  end
end

def current_player(board)
  if turn_count(board).odd?
  "O"
  else "X"
 end
end

def turn(board)
  "Please select 1-9 to make a move."
  input = gets.strip
  index = input_to_index(input)
  if valid_move?(board, index)
    move(board, index, current_player(board))
    display_board(board)
  else
    "Whoops! I'm sorry that's not a valid move. Please try again."
    turn(board)
  end
end

def won?(board)
  WIN_COMBINATIONS.detect do |combo|

  position_1 = board[combo[0]]
  position_2 = board[combo[1]]
  position_3 = board[combo[2]]

  if position_1 == "X" && position_2 == "X" && position_3 == "X" ||
     position_1 == "O" && position_2 == "O" && position_3 == "O"
     return combo
   end
  end
end

def full?(board)
  board.all? {|character| character == "X" || character == "O"}
end

def draw?(board)
  if full?(board) && !won?(board)
    true
  end
end

def over?(board)
  won?(board) || draw?(board) || full?(board)
end

def winner(board)
  won?(board) && board[won?(board)[0]]
end

def play(board)
  input = gets
  until over?(board)
    play(board)
end

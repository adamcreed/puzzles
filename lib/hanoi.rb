def main
  number_of_discs, goal_turn = get_values
  puts play_game(number_of_discs: number_of_discs, goal_turn: goal_turn)
end

def play_game(number_of_discs:, goal_turn:)
  initialize_game(number_of_discs: number_of_discs, goal_turn: goal_turn)

  move_disc until game_is_over?

  solution
end

def get_values
  print 'Enter the number of discs: '
  number_of_discs = gets.to_i

  print 'Enter the turn you want to see: '
  goal_turn = gets.to_i

  [number_of_discs, goal_turn]
end

def initialize_game(number_of_discs:, goal_turn:)
  @number_of_discs = number_of_discs
  @goal_turn = goal_turn
  @turn = 0
  @towers = [new_tower, new_tower, new_tower]
end

def new_tower
  tower = Array.new(@number_of_discs, 0)

  tower.fill { |i| i + 1 } if @first.nil?
  tower << Float::INFINITY

  @first = false

  tower
end

def move_disc
  @turn += 1

  if @turn.odd?
    move_smallest
  else
    move_only_other_moveable_disc
  end
end

def game_is_over?
  goal_turn_is_reached? or puzzle_is_solved?
end

def goal_turn_is_reached?
  @goal_turn == @turn
end

def puzzle_is_solved?
  @turn == 2 ** @number_of_discs - 1
end

def move_smallest
  remove_disc 1

  @number_of_discs.odd? ? move(1, 'left') : move(1, 'right')
end

def move_only_other_moveable_disc
  tops = find_tops
  disc = tops.sort[1]

  # regex matches disc not 1 or itself
  target = tops.index { |i| i.to_s =~ /[^1#{disc}]/ }

  remove_disc disc
  move(disc, target)
end

def remove_disc(number)
  origin = find_disc(number)
  @towers[@current][origin] = 0
end

def find_disc(number)
  @current = 0
  disc = 0

  @towers.each do |tower|
    disc = tower.index number
    break unless disc.nil?
    @current += 1
  end

  disc
end

def find_tops
  discs = @towers.map { |tower| tower.select { |disc| not(disc.zero?) }.min }

  discs.map { |disc| disc.nil? ? 0 : disc }
end

def move(disc, target)
  target = @current - 1 if target == 'left'
  target = @current - 2 if target == 'right'
  @towers[target][@towers[target].rindex(0)] = disc
end

def get_state
  state = ''
  @number_of_discs.times do |row|
    state << build_row(row)
  end

  state
end

def build_row(row)
  state = ''

  3.times do |col|
    state << build_tower_row(row, col)
  end

  state << "\n"

  state
end

def build_tower_row(row, col)
  tower = @towers[col]
  disc = tower[row]
  padding = @number_of_discs - tower[row]
  piece = ''

  piece << draw(padding, ' ')
  disc.zero? ? piece << '|' : piece << draw(disc_width(disc), '#')
  piece << draw(padding + 1, ' ') unless col == 2

  piece
end

def draw(number, symbol)
  part = ''
  number.times { part << symbol }

  part
end

def disc_width(disc)
  disc * 2 + 1
end

def solution
  "#{get_state}#{2 ** @number_of_discs - 1}"
end

main if __FILE__ == $PROGRAM_NAME

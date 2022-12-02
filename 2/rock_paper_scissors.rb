# input of rock paper scissors moves
# two letters per line, opponents move and your move respectively
# not every move is a winner so as to not be suspected of cheating
# Winner of tourney has highest score
# Total score is sum of scores for each round
# score for a round is your selected shape/move + outcome of round 
# 1 for rock, 2 for paper, 3 for scissors
# 0 for lose, 3 for draw, 6 for win

# A: rock
# B: paper
# C: scissors

# X: 1 - rock
# Y: 2 - paper
# Z: 3 - scissors

# win: 6
# draw: 3
# lose: 0

# Part 1:
# calculate the score by following the input

class RockPaperScissors
  attr_reader :rounds, :current_round, :total_score
  
  def initialize(input)
    @rounds = IO.readlines(input, chomp: true)
    @current_round = 0
    @total_score = 0
  end
  
  def run_tourney
    until current_round >= rounds.size
      play_round
    end
    total_score
  end
  
  def play_round
    opponent_move, your_move = rounds[current_round].split(" ")
    result = find_winner(opponent_move, your_move)
    score = ROUND_POINTS[result] + PLAY_POINTS[your_move]
    @current_round += 1
    @total_score += score
    score 
  end
  
  def find_winner(opponent, you)
    opponent_num = GRID_COORDS[opponent]
    your_num = GRID_COORDS[you]
    GRID[opponent_num][your_num]
  end
  
  GRID = [
    ['draw','win', 'lose'],
    ['lose','draw', 'win'],
    ['win', 'lose', 'draw']
  ]
  
  GRID_COORDS = {
    'A' => 0,
    'B' => 1,
    'C' => 2,
    'X' => 0,
    'Y' => 1,
    'Z' => 2
  }
  
  ROUND_POINTS = {
     'win' => 6,
     'draw' => 3,
     'lose' => 0
    }
    
  PLAY_POINTS = {
    'X' => 1,
    'Y' => 2,
    'Z' => 3
  }
  
  OPPONENT_MOVE = {
    'A' => 'rock',
    'B' => 'paper',
    'C' => 'scissors'
  }
  
  YOUR_MOVE = {
    'X' => 'rock',
    'Y' => 'paper',
    'Z' => 'scissors'
  }
end

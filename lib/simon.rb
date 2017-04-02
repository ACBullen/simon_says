require 'Colorize'
class Simon
  COLORS = %w(red blue green yellow)

  attr_accessor :sequence_length, :game_over, :seq

  def initialize
    @sequence_length, @game_over, @seq = 1, false, []

  end

  def play
    until game_over
      take_turn
      @sequence_length += 1
    end

    game_over_message
    reset_game
  end

  def take_turn
    puts "Let's play a game of Simon Says!"
    puts "Type the colors you see and then hit Enter!"
    puts "Ready?..."
    sleep(2)
    puts "Go!"
    sleep(0.5)
    until game_over
      show_sequence
      require_sequence
      round_success_message
      self.sequence_length += 1
    end
    game_over_message
    reset_game
    puts "Play again?(y/n)"
    choice = gets.chomp
    take_turn if choice == 'y'
    print 'Goodbye!'
  end

  def show_sequence
    add_random_color
    seq.each do |color|
      case color
      when "red"
        puts "red".red
      when "blue"
        puts "blue".blue
      when "yellow"
        puts "yellow".yellow
      when "green"
        puts "green".green
      end
      sleep(0.5)
    end
    sleep(1)
    print "\e[H\e[2J"
  end

  def require_sequence
    player_attempt = gets.chomp
    player_colors = player_attempt.split(' ')
    unless player_colors == self.seq
      self.game_over = true
    end
  end

  def add_random_color
    @seq << COLORS[rand(4)]
  end

  def round_success_message
    puts "You got it!"
  end

  def game_over_message
    puts "That wasn't it!"
    print "\n"
    print @seq
    print "\n"
    puts "Game Over..."
  end

  def reset_game
    self.sequence_length = 1
    self.game_over = false
    self.seq = []
  end
end

if __FILE__ == $PROGRAM_NAME
  today_s_game = Simon.new
  today_s_game.take_turn
end

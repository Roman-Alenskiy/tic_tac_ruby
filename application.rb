class Game
	attr_accessor :player1, :player2, :cells

	def initialize
		@cells = {  "a1" => " ", "a2" => " ", "a3" => " ",
					"b1" => " ", "b2" => " ", "b3" => " ",
					"c1" => " ", "c2" => " ", "c3" => " "  }
	end

	def show_grid
		print "   | 1 | 2 | 3 |\n"
		print " --+---+---+---+\n"
		print " a | #{@cells["a1"]} | #{@cells["a2"]} | #{@cells["a3"]} |\n"
		print " --+---+---+---+\n"
		print " b | #{@cells["b1"]} | #{@cells["b2"]} | #{@cells["b3"]} |\n"
		print " --+---+---+---+\n"
		print " c | #{@cells["c1"]} | #{@cells["c2"]} | #{@cells["c3"]} |\n"
		print " --+---+---+---+\n"
		print "\n"
	end

	def player_turn
		print "#{@active_player} (#{@active_symbol}), now is your turn!\n"
	end

	def cells_handler
		player_turn
		flag = false
		until flag do
			cell = gets.chomp
			cell.downcase!
			restart if cell == "r"
			flag = true if @cells[cell] == " "
			if flag
				step(cell)
			elsif /^[abcABC][123]$/ === cell
				print "#{cell} is already taken!\n"
			else
				print "Wrong cell!\n"
			end
		end
	end

	def win_check
		array_of_as = [@active_symbol] * 3
		condition = (([@cells["a1"], @cells["a2"], @cells["a3"]]) == array_of_as ||
					([@cells["b1"], @cells["b2"], @cells["b3"]]) == array_of_as ||
					([@cells["c1"], @cells["c2"], @cells["c3"]]) == array_of_as ||
					([@cells["a1"], @cells["b1"], @cells["c1"]]) == array_of_as ||
					([@cells["a2"], @cells["b2"], @cells["c2"]]) == array_of_as ||
					([@cells["a3"], @cells["b3"], @cells["c3"]]) == array_of_as ||
					([@cells["a1"], @cells["b2"], @cells["c3"]]) == array_of_as ||
					([@cells["a3"], @cells["b2"], @cells["c1"]]) == array_of_as)
		if 	condition
			print "^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^\n"
			print "\n"
			print "   #{@active_player} win! Congratz!   \n"
			print "\n"
			print "^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^\n\n"
			print "Start new game? [y/n]\n"

			loop do
				next_game = gets.chomp
				next_game.downcase!
				if /^[yn]$/ === next_game
					restart if next_game == "y"
					abort if next_game == "n"
				else
					print "Wrong answer!\n"
				end
			end
		end
	end

	def step(cell)
		cell.downcase!
		@cells[cell] = @active_symbol
		show_grid
		win_check
		switch_player
	end

	def switch_player
		if @active_player == @player1
			@active_player = @player2
			@active_symbol = "O"
		else
			@active_player = @player1
			@active_symbol = "X"
		end
		cells_handler
	end

	def start
		print "========================================\n"
		print "#                                      #\n"
		print "#   Starting a new Tic-Tac-Toe Game!   #\n"
		print "#       (enter 'r' for restart)        #\n"
		print "#                                      #\n"
		print "========================================\n"
		create_players
	end

	def restart
		initialize
		@active_player = @player1
		@active_symbol = "X"
		print "\n=================\n"
		print "Restarting...\n"
		print "=================\n\n"
		show_grid
		cells_handler
	end

	def create_players
		print "\nWhat is Player 1 (X) name?\n"
		@player1 = gets.chomp
		print "\n"
		print "What is Player 2 (O) name?\n"
		@player2 = gets.chomp
		print "\n"
		@active_player = @player1
		@active_symbol = "X"
		show_grid
		cells_handler
	end

end

game = Game.new
game.start

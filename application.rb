class Game
	attr_accessor :player1, :player2, :cells, :draw_marker

	def initialize
		@cells = {  "a1" => " ", "a2" => " ", "a3" => " ",
					"b1" => " ", "b2" => " ", "b3" => " ",
					"c1" => " ", "c2" => " ", "c3" => " "  }
		@draw_marker = 0
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
			elsif cell =~ /^[abcABC][123]$/
				print "#{cell} is already taken!\n"
			else
				print "Wrong cell!\n"
			end
		end
	end

	def win_check
		# array_of_active_symbols == ["X","X","X"] or ["O","O","O"] in dependence of @active_symbol
		array_of_active_symbols = [@active_symbol] * 3 
		condition = (([@cells["a1"], @cells["a2"], @cells["a3"]]) == array_of_active_symbols ||
					([@cells["b1"], @cells["b2"], @cells["b3"]]) == array_of_active_symbols ||
					([@cells["c1"], @cells["c2"], @cells["c3"]]) == array_of_active_symbols ||
					([@cells["a1"], @cells["b1"], @cells["c1"]]) == array_of_active_symbols ||
					([@cells["a2"], @cells["b2"], @cells["c2"]]) == array_of_active_symbols ||
					([@cells["a3"], @cells["b3"], @cells["c3"]]) == array_of_active_symbols ||
					([@cells["a1"], @cells["b2"], @cells["c3"]]) == array_of_active_symbols ||
					([@cells["a3"], @cells["b2"], @cells["c1"]]) == array_of_active_symbols)
		if 	condition
			print "^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^\n"
			print "\n"
			print "   #{@active_player} win! Congratz!   \n"
			print "\n"
			print "^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^\n\n"

			new_game
		end
	end

	def draw_check(draw_marker)
		if draw_marker == 9
			print ">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>\n"
			print "\n"
			print "                DRAW!   \n"
			print "\n"
			print ">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>\n\n"

			new_game
		end
	end

	def step(cell)
		cell.downcase!
		@cells[cell] = @active_symbol
		@draw_marker += 1
		show_grid
		draw_check(@draw_marker)
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

	def new_game
		print "Start new game? [y/n]\n"
		loop do
			new_game = gets.chomp
			new_game.downcase!
			if new_game =~ /^[yn]$/
				restart if new_game == "y"
				exit if new_game == "n"
			else
				print "Wrong answer!\n"
			end
		end
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

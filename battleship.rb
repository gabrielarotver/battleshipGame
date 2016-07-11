require_relative 'player'
class Battleship

	@@gameType = {"1" => 5, "2" => 10}
	@@maxBoats = {"1" => 5, "2" => 20}
	def initialize()
		puts "\nLET'S PLAY BATTLESHIP!!!\n"
	end

	def readInstructions()

		begin
			puts "\n Choose what type of game you want to play:\n1. Short\n2. Long\n"
			puts "Enter your choice here: "
			type = gets.chomp.strip

			if (type != "1" && type != "2")
				puts "Invalid input!"
			end
		end until (type == "1" || type == "2")


		puts "\nYou will be playing against the computer."
		print "What is your name? >"
		name = $stdin.gets.chomp.capitalize
		@player1 = Player.new(name, @@gameType[type], @@maxBoats[type])
		@computer = Player.new("Computer", @@gameType[type], @@maxBoats[type])
		puts "Okay #{name}! Let's start the game!\n\n"
		@player1.printPlayerBoard()

	end

	def playGame()
		readInstructions()

		winner = false
		name = nil

		while (!winner)
			winner = @player1.playOneTurn(@computer)

			if(winner)
				name = @player1.playerName
				@player1.printOpponentBoard(@computer)
				break
			end

			winner = @computer.computerPlayOneTurn(@player1)

			if(winner)
				name = @computer.playerName
				#@computer.printOpponentBoard(@player1)
				break
			end

		end

		puts "\n\n#{name} WINS!\n\n"
	end

end


battleship = Battleship.new()
battleship.playGame()
require_relative 'gameboard'
class Player

	attr_reader :playerName
	attr_reader :gameBoard

	def initialize(username, matrixMax, maxBoats)
		@playerName = username
		@gameBoard = GameBoard.new(matrixMax, maxBoats)
	end

	# play one turn and return whether you win or not
	def playOneTurn(opponent)
		puts "\n\n#{opponent.playerName}'s board:"
		@gameBoard.printOpponentBoard(opponent.gameBoard)
		puts "\n\nNow it's time to shoot your opponent."
		
		# validate user row and column (WITHOUT REPETITIONS)
		valid = false 

		until valid == true

			print "Type the LETTER of the COLUMN you want to shoot: "
			col = $stdin.gets.chomp.strip.upcase 

			print "Type the NUMBER of the row you want to shoot: "
			row = $stdin.gets.chomp.to_i
	
			valid = @gameBoard.validateInputToShoot(opponent.gameBoard, row, col)

			if valid == "REPEAT"
				puts "\nYou already shot your opponent there!\n"
				valid = false

			elsif valid == false
				puts "\nInvalid input! Please try again!\n"
				
			end
		end


		if(@gameBoard.shoot(opponent.gameBoard, row, col) == true)
			puts "\n\nYOU HIT THE OPPONENT!!!!!!!!!!!!!!!!\n"
		else
			puts "\n\nYOU MISSED!!!!!!!!!!!!!!!!!!!\n"
		end

		sleep 2

		if(@gameBoard.numBoatsHit == @gameBoard.maxBoats)
			return true
		else
			return false
		end
	end

	def printPlayerBoard()
		puts "\n#{playerName}'s board:"
		@gameBoard.printOwnBoard()
	end

	def printOpponentBoard(opponent)
		puts "\n#{opponent.playerName}'s board:"
		@gameBoard.printOpponentBoard(opponent.gameBoard)
	end

	def computerPlayOneTurn(user)
		# validate computer row and column (WITHOUT REPETITIONS)
		valid = false 

		until valid == true
			row = Random.rand(0..user.gameBoard.matrixMax)
			col = Random.rand(0..user.gameBoard.matrixMax)
			# puts "\n\n",row,col # make sure repeated row/col are being changed
			valid = @gameBoard.validateInputToShoot(user.gameBoard, row, col)
		end

		#FIX THIS HERE
		colKey = GameBoard.colConversions.key(col)
		#colKey = @gameBoard.colConversions.key(col) # Doesn't work. colConversions not a method issue. Ask?

		puts "\n\nThey computer is shooting at: #{colKey}#{row}"

		if(@gameBoard.shoot(user.gameBoard, row, colKey) == true)
			puts "\n\nTHE COMPUTER HIT YOU!"
		else
			puts "\n\nCOMPUTER MISSED!"
		end

		puts "\n\n#{user.playerName}'s board:"
		user.gameBoard.printOwnBoard()

		if(@gameBoard.numBoatsHit == @gameBoard.maxBoats)
			return true
		else
			return false
		end
	end

end
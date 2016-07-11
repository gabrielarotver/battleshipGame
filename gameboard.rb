class GameBoard

	attr_reader :numBoatsHit

	attr_reader :maxBoats

	attr_reader :gameBoard

	attr_reader :matrixMax

	#attr_reader :colConversions

	@@colConversions = {"A" => 0, "B" => 1, "C" => 2, "D" => 3,
		"E" => 4, "F" => 5, "G" => 6, "H" => 7, "I" => 8, "J" => 9}

	def initialize(matrixMax, maxB)
		@gameBoard = [] # shows ship locations
		@numBoatsHit = 0 #20 boats in board total

		 #length and width of matrix starting with 0! i.e. 5x5, matrixMax = 5, @matrixMax = 4
		@matrixMax = matrixMax - 1
		@maxBoats = maxB
		

		(0..@matrixMax).each do |row|
			@gameBoard[row] = []

			(0..@matrixMax).each do |col|
				@gameBoard[row][col] = "-"
			end
		end

		counter = 0
		while (counter < @maxBoats)
			row = Random.rand(0..@matrixMax)
			col = Random.rand(0..@matrixMax)

			if (@gameBoard[row][col] == "-")
				@gameBoard[row][col] = "🛥"
				counter += 1
			end

		end

	end

	# validate the row and column for a shot, make sure user is not shooting at the sane place over and over again
	def validateInputToShoot(opponentGameBoard, row, col)

		# computer validate input
		if(col.is_a? Integer)
			if(opponentGameBoard.gameBoard[row][col] == "-" || opponentGameBoard.gameBoard[row][col] == "🛥")
				return true
			else
				return false
			end

		# user validate input. Return "REPEAT" if col and row choice was repetitive.
		elsif ((0..@matrixMax).include?(row) && !(@@colConversions[col].nil?) && ( (0..@matrixMax).include?(@@colConversions[col]) ))

			if(opponentGameBoard.gameBoard[row][@@colConversions[col]] == "-" || opponentGameBoard.gameBoard[row][@@colConversions[col]] == "🛥")
				return true
			else
				return "REPEAT"
			end
		else
			return false
		end
	end

	# ask getter/setter methods or use attr_something?
	def self.colConversions
		return @@colConversions
	end

	# shoot opponent, return if caller object won!
	def shoot(opponentGameBoard, row, col)
		
		if (opponentGameBoard.gameBoard[row][@@colConversions[col]] == "🛥")
			opponentGameBoard.gameBoard[row][@@colConversions[col]] = "🔥"
			@numBoatsHit += 1
			return true
		else
			opponentGameBoard.gameBoard[row][@@colConversions[col]] = "♒"
			return false
		end

	end





	#used to see the positions of all the boats
	def printOwnBoard()

		topRow = "\n\t  "
		("A"..@@colConversions.key(@matrixMax)).each do |letter|
			topRow << letter << "   "
		end

		print topRow, "\n"

		(0..@matrixMax).each do |row|
			print "\t", row, " "
			(0..@matrixMax).each do |col|
				print @gameBoard[row][col], "   "
			end
			print "\n"
		end
	end

	# Print opponent's board, hidding the boats that have not been shot at
	def printOpponentBoard(opponentGameBoard)

		topRow = "\n\t  "
		("A"..@@colConversions.key(@matrixMax)).each do |letter|
			topRow << letter << "   "
		end

		print topRow, "\n"

		(0..@matrixMax).each do |row|
			print "\t", row, " "
			(0..@matrixMax).each do |col|
				if (opponentGameBoard.gameBoard[row][col] == "🔥" || opponentGameBoard.gameBoard[row][col] == "♒")
					print opponentGameBoard.gameBoard[row][col], "   "
				else
					print "-   "
				end
			end
			print "\n"
		end
	end

end
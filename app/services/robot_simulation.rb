class RobotSimulation
	DIRECTIONS = %w[NORTH EAST SOUTH WEST]

	def initialize(robot, commands)
		@robot = robot
		@commands = commands
		@positions = []
	end

	def simulate
		@commands.each do |command|
			if command.include? 'PLACE'
				set_initial_position
			elsif command == 'REPORT'
				store_positions
				@robot.save
			else
				process_command command
			end
		end
		@robot.save
	end

	def final_position
		@positions
	end

	private
	
	def store_positions
		@positions << "#{@robot.x_coordinate},#{@robot.y_coordinate},#{@robot.facing}"
	end

	def process_command command
		case command
	when 'LEFT'
		move_left
	when 'RIGHT'
		move_right
	when 'MOVE'
		move_forward
	end
	end

	def move_left
		index = DIRECTIONS.index @robot.facing
		@robot.facing = DIRECTIONS[index - 1]
	end

	def move_right
		index = DIRECTIONS.index @robot.facing
		index = index == 3 ? -1 : index
		@robot.facing = DIRECTIONS[index + 1]
	end

	def move_forward
		case @robot.facing
		when 'NORTH'
			@robot.y_coordinate += 1 if @robot.y_coordinate + 1 < 5
		when 'SOUTH'
			@robot.y_coordinate -= 1 if @robot.y_coordinate - 1 > 0
		when 'EAST'
			@robot.x_coordinate += 1 if @robot.x_coordinate + 1 < 5
		when 'WEST'
			@robot.x_coordinate -= 1 if @robot.x_coordinate - 1 > 0
		end				
	end

	def set_initial_position
		return unless @commands.first.include? 'PLACE'

		command = @commands.first
		command = command.split(' ')[1].split(',')
		@robot.x_coordinate = command[0].to_i
		@robot.y_coordinate = command[1].to_i
		@robot.facing = command[2].to_s
	end
end
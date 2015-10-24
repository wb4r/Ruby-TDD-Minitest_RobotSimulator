class Robot
  attr_reader :compass

  def initialize
    @compass = [:north, :east, :south, :west]
    @facing_to = true
    @x_axis, @y_axis = [], []
  end

  def orient(direction)
    if compass.include?(direction) 
      @facing_to = direction
    else
      raise ArgumentError.new("Wrong directions provided.")
    end
  end

  def bearing
    @facing_to
  end

  def turn_right
    index = @compass.find_index(@facing_to) + 1
    index = 0 if @compass[index].nil?
    @facing_to = @compass[index]
  end

  def turn_left
    index = @compass.find_index(@facing_to) - 1
    index = 3 if @compass[index].nil?
    @facing_to = @compass[index]
  end

  def at(x, y)
    @x_axis << x 
    @y_axis << y     
  end

  def coordinates 
    [@x_axis, @y_axis].flatten!
  end

  def advance
    case @facing_to
    when :north then @y_axis[0] += 1
    when :east then @x_axis[0] += 1
    when :south then @y_axis[0] -= 1
    when :west then @x_axis[0] -= 1
    end
  end
end


class Simulator

  def initialize
    @commands = []
  end

  def instructions(letter_orders)
   counter = 0
    while counter < letter_orders.length
      case letter_orders[counter]
      when 'L' then @commands << :turn_left
      when 'R' then @commands << :turn_right
      when 'A' then @commands << :advance
      end
     counter += 1
    end
    @commands
  end

  def place(robot, coordinates)
    robot.orient(coordinates[:direction])
    robot.at(coordinates[:x], coordinates[:y])
  end

  def evaluate(robot, commands)
    @simulator = Simulator.new
    commands = @simulator.instructions(commands)

    counter = 0    
    while counter < commands.length
      case commands[counter]
      when :turn_right then robot.turn_right
      when :turn_left then robot.turn_left
      when :advance then robot.advance
      end
      counter += 1      
    end        
  end
end
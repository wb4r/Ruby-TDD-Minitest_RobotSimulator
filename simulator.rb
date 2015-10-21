require 'pry'

class Robot
  attr_reader :compass
  attr_accessor :facing_to

  def initialize
    @compass = [:north, :east, :south, :west]
    @facing_to = true
    @x_axis = []
    @y_axis = []
  end

  def orient(direction)
    if compass.include?(direction) 
      @facing_to = direction
    else
      raise ArgumentError.new("Waddayamean? Not gonna happen. Out.")
    end
  end

  def bearing
    @facing_to
  end

  def turn_right
    index = @compass.find_index(@facing_to) + 1
    if @compass[index].nil? 
      index = 0
    end
    @facing_to = @compass[index]
  end

  def turn_left
    index = @compass.find_index(@facing_to) - 1
    if @compass[index].nil? 
      index = 3
    end
    @facing_to = @compass[index]
  end

  def at(x, y)
    @x_axis << x 
    @y_axis << y     
  end

  def coordinates
    location = []
    location << @x_axis
    location << @y_axis
    location.flatten!   
  end

  def advance
    case @facing_to
    when :north
      @y_axis =+ 1
    when :east
      @x_axis =+ 1
    when :south
      @y_axis =- 1
    when :west
      @x_axis =- 1
    end
  end
end
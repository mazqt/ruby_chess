class Player
  attr_accessor :colour
  attr_reader :name
  def initialize(name)
    @name = name
    @colour = ""
  end
end

class InputParser
  attr_reader :input

  def initialize(input)
    @input = input
  end

  def club
    input.downcase.gsub('-', ' ')
  end
end
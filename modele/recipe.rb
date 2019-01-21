# Recipe class
class Recipe
  attr_reader :name, :description, :prep_time, :difficulty
  attr_accessor :done
  def initialize(name,
                 description,
                 prep_time = 'unknown time',
                 difficulty = 'unknown difficulty')
    @name = name
    @description = description
    @prep_time = prep_time
    @done = false
    @difficulty = difficulty
  end
end

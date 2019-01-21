require 'csv'
require_relative 'recipe'

# Repo class
class Cookbook
  def initialize(csv_file_path)
    @csv_file_path = csv_file_path
    @recipes = from_csv(@csv_file_path)
  end

  def all
    @recipes
  end

  def add_recipe(recipe)
    @recipes << recipe
    to_csv(@csv_file_path)
  end

  def remove_recipe(index)
    @recipes.delete_at(index)
    to_csv(@csv_file_path)
  end

  def recipe_done(index)
    @recipes[index].done = true
  end

  private

  def from_csv(csv_file_path)
    recipes = []
    CSV.foreach(csv_file_path) do |row|
      recipes << Recipe.new(row[0], row[1], row[2], row[3])
    end
    recipes
  end

  def to_csv(csv_file_path)
    CSV.open(csv_file_path, 'wb') do |csv|
      @recipes.each do |recipe|
        csv << [recipe.name,
                recipe.description,
                recipe.prep_time,
                recipe.difficulty]
      end
    end
  end
end

require_relative "recipe"
require "csv"

class Cookbook
  def initialize(csv_file_path)
    @recipes = [] # array Recipe instances
    @csv_file_path = csv_file_path

    load_csv
  end

  def all
    @recipes
  end

  def find(index)
    @recipes[index]
  end

  def add_recipe(new_recipe)
    @recipes << new_recipe
    update_csv
  end

  def remove_recipe(index)
    @recipes.delete_at(index)
    update_csv
  end

  def persist!
    update_csv
  end

  private

  def update_csv
    # Mirror memory into the CSV
    CSV.open(@csv_file_path, "wb") do |csv_file|
      csv_file << ["name", "description", "rating", "done"]
      @recipes.each do |recipe|
        csv_file << [recipe.name, recipe.description, recipe.rating, recipe.done?]
      end
    end
  end

  def load_csv
    # Load the CSV
    CSV.foreach(@csv_file_path, headers: true, header_converters: :symbol) do |row|
      # { ..., rating: "5", done: "false" }
      # Type cast
      row[:rating] = row[:rating].to_i
      row[:done] = row[:done] == "true"
      # { ..., rating: 5, done: false }
      recipe = Recipe.new(row)
      @recipes << recipe
    end
  end
end

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

  def add_recipe(new_recipe)
    @recipes << new_recipe
    update_csv
  end

  def remove_recipe(index)
    @recipes.delete_at(index)
    update_csv
  end

  private

  def update_csv
    # Mirror memory into the CSV
    CSV.open(@csv_file_path, "wb") do |csv_file|
      csv_file << ["name", "description"]
      @recipes.each do |recipe|
        csv_file << [recipe.name, recipe.description]
      end
    end
  end

  def load_csv
    # Load the CSV
    CSV.foreach(@csv_file_path, headers: true, header_converters: :symbol) do |row|
      # With headers true (add headers to the CSV) and
      # header converters, we get a "hash" of key: "Value" like this:
      # { name: "Caipirinha", description: "Lemon and Cachaça" }
      recipe = Recipe.new(row)
      @recipes << recipe
    end
  end
end

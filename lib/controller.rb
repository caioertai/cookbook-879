require_relative "view"

class Controller
  def initialize(cookbook)
    @cookbook = cookbook
    @view = View.new
  end

  def list
    # Ask COOKBOOK for all recipes
    recipes = @cookbook.all
    # Ask VIEW to display all of them
    @view.display(recipes)
  end

  def create
    # Ask VIEW to ask the user for a name
    recipe_name = @view.ask_for_string("name")
    # Ask VIEW to ask the user for a description
    recipe_description = @view.ask_for_string("description")
    # Ask MODEL to instantiate a recipe
    new_recipe = Recipe.new(name: recipe_name, description: recipe_description)
    # Ask COOKBOOK to persist it
    @cookbook.add_recipe(new_recipe)
  end

  def destroy
    # Ask COOKBOOK for all recipes
    recipes = @cookbook.all
    # Ask VIEW to display them
    @view.display(recipes)
    # Ask VIEW to ask the user for a number
    recipe_index = @view.ask_for_index
    # Ask COOKBOOK to remove it
    @cookbook.remove_recipe(recipe_index)
  end
end

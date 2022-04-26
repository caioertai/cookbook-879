require_relative "all_recipes_scraper"
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
    # Ask VIEW to ask the user for a rating
    recipe_rating = @view.ask_for_string("rating")
    # Ask MODEL to instantiate a recipe
    new_recipe = Recipe.new(name: recipe_name, description: recipe_description, rating: recipe_rating)
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

  def mark
    # Ask REPO for all recipes
    recipes = @cookbook.all
    # Ask VIEW to display all recipes
    @view.display(recipes)
    # Ask VIEW to ask user for the index of the one to mark
    index = @view.ask_for_index
    # Ask REPO for the recipe of that index
    recipe = @cookbook.find(index)
    # Ask RECIPE to mark itself as done!
    recipe.mark_as_done! # @done => false => true
    # Ask REPO to persist changes
    @cookbook.persist!
  end

  def import
    user_ingredient = @view.ask_for_string("ingredient")
    scraped_recipes = AllRecipesScraper.new(user_ingredient).call
    @view.display(scraped_recipes)
    index = @view.ask_for_index
    recipe = scraped_recipes[index]
    @cookbook.add_recipe(recipe)
  end
end

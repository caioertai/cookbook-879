require_relative "recipe"
require "open-uri"
require "nokogiri"

class AllRecipesScraper
  def initialize(ingredient)
    @ingredient = ingredient
  end

  def call
    url = "https://www.allrecipes.com/search/results/?search=#{@ingredient}"
    file_string = URI.open(url).read
    doc = Nokogiri::HTML.parse(file_string)
    card_elements = doc.search(".card__detailsContainer").first(5)
    card_elements.map do |card_element|
      # return a recipe instance
      name = card_element.at("h3").text.strip
      description = card_element.at(".card__summary").text.strip
      rating = card_element.search(".rating-star.active").count
      Recipe.new(name: name, description: description, rating: rating)
    end
  end
end

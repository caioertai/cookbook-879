class View
  def ask_for_string(label)
    puts "What is the #{label}?"
    gets.chomp
  end

  def ask_for_index
    puts "Which one? (by number)"
    gets.chomp.to_i - 1
  end

  def display(recipes)
    # recipes => array of Recipe instances
    recipes.each_with_index do |recipe, index|
      # recipe => Recipe instance
      puts "#{index + 1}. #{recipe.name}\n---- #{recipe.description}\n---"
    end
  end
end

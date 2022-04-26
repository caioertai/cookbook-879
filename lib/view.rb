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
      box = recipe.done? ? "[x]" : "[ ]"
      puts <<~STRING
        #{index + 1}. #{box} #{recipe.name} (#{'*' * recipe.rating})
        ------ #{recipe.description}
        ---
      STRING
    end
  end
end

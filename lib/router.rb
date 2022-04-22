class Router
  def initialize(controller)
    @controller = controller
    @running = true
  end

  def run
    while @running
      display_menu
      dispatch
    end
  end

  private

  def display_menu
    puts "1. To list all recipes"
    puts "2. To add a Recipe"
    puts "3. Remove a recipe"
    puts "0. To quit"
    puts "What do you want to do?"
  end

  def dispatch
    case gets.chomp.to_i
    when 1 then @controller.list
    when 2 then @controller.create
    when 3 then @controller.destroy
    when 0 then @running = false
    end
  end
end

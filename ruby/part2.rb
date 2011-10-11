# make_beverage do |beverage| 
#   soy 
#   soy 
#   latte 
# end.cost

# class Latte
#   def cost 
#       1.00 
#   end 
# end

class Soy 
  attr_accessor :beverage

  def initialize(beverage) 
    @beverage = beverage 
  end

  def cost 
    0.50 + beverage.cost 
  end 
end


#puts Soy.new(Soy.new(Latte.new)).cost


class Whip
  def self.cost 
    0.50 
  end 
end

class Skim
  def self.cost 
    0.80 
  end 
end

class Drink
  attr_accessor :condiments
  def initialize(&block)
    self.condiments = []
    instance_eval(&block) if block_given?
  end

  def cost
    self.class.cost + condiments.inject(0){|sum,x| sum + x.cost }
  end

  def method_missing(meth, *args, &block)
    const = meth.to_s.capitalize
    if Kernel.const_defined?(const)
      condiments << Kernel.const_get(const)
    else
      super  
    end
  end
end


class Mocha < Drink
  def self.cost 
    2.50 
  end          
end


class Coffee < Drink
  def self.cost 
    1.80 
  end          
end

drink = Coffee.new
puts drink.cost

drink = Mocha.new do
  whip
  skim
end

puts drink.cost
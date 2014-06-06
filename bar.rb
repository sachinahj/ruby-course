require 'time' # you're gonna need it

class Item
  attr_reader :name, :price, :discount
  def initialize(name, price, discount = true)
    @name = name
    @price = price
    @discount = discount
  end
end


class Bar
  attr_reader :name
  attr_accessor :menu_items

  def initialize(name)
    @name = name
    @menu_items = []
    @happy_discount = 0
  end

  def add_menu_item(name, price)
    @menu_items << Item.new(name, price)
  end

  def drink_discount(item)
    # if @menu_items.any? {|x| x.name.downcase == item.downcase}
    @menu_items.each do |x|
      if x.name.downcase == item.downcase
        return @happy_discount if x.discount
      else
        return 0
      end
      return 0
    end
  end

  def happy_discount
    if happy_hour?
      if Time.now.wday == 1 || Time.now.wday == 3
        return @happy_discount
      else
        return (@happy_discount / 2.0)
      end
    else
      return 0
    end
  end

  def happy_discount=(discount)
    if discount > 1
      @happy_discount = 1
    elsif discount < 0
      @happy_discount = 0
    else
      @happy_discount = discount
    end
  end

  def happy_hour?
    if Time.now.hour == 15
      return true
    else 
      return false
    end
  end
end

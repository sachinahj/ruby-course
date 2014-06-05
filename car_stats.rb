class CarStats
  # TODO
  def self.calc_top_color(cars)
    freq = cars.inject(Hash.new(0)) { |h,v| h[v.color] += 1; h }
    p freq
    car = cars.max_by { |v| freq[v.color] }
    car.color
  end
  def self.calc_bottom_color(cars)
    freq = cars.inject(Hash.new(0)) { |h,v| h[v.color] += 1; h }
    car = cars.min_by { |v| freq[v.color] }
    car.color
  end
end
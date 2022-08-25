# frozen_string_literal: true

categories = %w[Еда Машины Девайсы Одежда]

categories.each do |c|
  Category.create(name: c)
end

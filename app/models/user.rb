class User < ActiveRecord::Base
  has_many :friends
  has_many :meals
  has_many :workouts
end

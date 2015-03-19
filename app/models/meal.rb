class Meal < ActiveRecord::Base
  belongs_to :user
  include PublicActivity::Model
  tracked
end

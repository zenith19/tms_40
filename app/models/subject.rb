class Subject < ActiveRecord::Base
  has_many :tasks , dependent: :destroy
  has_many :users_subject
  has_many :users, through: :users_subject
  accepts_nested_attributes_for :tasks, allow_destroy: true
end

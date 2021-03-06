class Post < ActiveRecord::Base
  PER_PAGE = 3

  include Voteable
  include Sluggable

  default_scope { order('created_at ASC') }

  belongs_to :creator, foreign_key: 'user_id', class_name: 'User' # We write this instead of `belongs_to :user` because we are not following rails convention and therefore have to explicitly specify the foreign_key and class_name 
  has_many :comments
  has_many :post_categories
  has_many :categories, through: :post_categories

  validates :title, presence: true, length: {minimum: 5}
  validates :description, presence: true
  validates :url, presence: true, uniqueness: true

  sluggable_column :title # calls method from Sluggable module

end
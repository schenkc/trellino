class Post < ActiveRecord::Base

  belongs_to :user, inverse_of: :posts

  has_many :post_shares, inverse_of: :post

  has_many :circles, through: :post_shares, source: :circle, inverse_of: :posts

  has_many :links, inverse_of: :post
end
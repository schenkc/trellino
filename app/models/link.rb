class Link < ActiveRecord::Base
  validates :post, presence: true

  belongs_to :post, inverse_of: :links

end

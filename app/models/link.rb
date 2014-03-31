class Link < ActiveRecord::Base

  belongs_to :post, inverse_of: :link

end

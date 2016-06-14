class Reseller < ActiveRecord::Base
  validates :name, :presence => true
  validates :post_code, :presence => true

  default_scope {order(post_code: :asc)}
end

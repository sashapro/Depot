class Product < ActiveRecord::Base
  has_many :line_items

  before_destroy :ensure_not_referenced_by_any_line_item

  #validates :title, :description, :image_url, :presence => true
  #validates :price, :numericality => {:greater_than_or_equal_to => 0.01}
  #validates :title, :uniqueness => true
  #validates :image_url, :format => {
  #    :with   => %r{\.(gif|jpg|png)$}i,
  #    :message => 'must be a URL for GIF, JPG or PNG image.' }
  #moe
  #validates :description => {:less_than_or_equal_to => 1000}

  validates :title, :author, :publisher, :description, :image_url, presence: {
    message: 'cannot be blank, product not saved'}
  validates :price,       numericality: { greater_than_or_equal_to: 0.01 }
  validates :title,       uniqueness: {
   message: 'has already been taken' },
    length: {
   minimum: 10,
   maximum: 100,
 too_short: 'is too short and must contain at least 10 characters',
  too_long: 'name must be shorter then 100 characters' }
  validates :image_url,   allow_blank: true, format: {
      with: %r{\.(gif|jpg|png)$}i,
   message: 'must be a URL for GIF, JPG or PNG image.' }
  validates :description, length: {
   maximum: 1000,
  too_long: 'must be less then 1000 characters' }
  validates :author,      length: {
   maximum: 100,
  too_long: 'name must be shorter then 100' }
  PUBLISHER = %w(pub1 pub2 pub3 pub4 pub5)
  validates :publisher,   inclusion: {
        in: PUBLISHER,
   message: "%{value} is not a valid, choose from #{PUBLISHER}" }

  private
  # ensure that there are no line items referencing this product
  def ensure_not_referenced_by_any_line_item
    if line_items.empty?
      return true
    else
      errors.add(:base, 'Line Items present')
      return false
    end
  end

end

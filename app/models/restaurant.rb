class Restaurant < ActiveRecord::Base

  validates :name, presence: true, length: { minimum: 3 }, uniqueness: true
  belongs_to :user
  has_many :reviews,
        -> { extending WithUserAssociationExtension },
        dependent: :destroy

  has_attached_file :image, :style => { :thumb => ["210x210#", :jpg] },
                    :default_url => "/images/:style/missing.png"

  validates_attachment :image

  def build_review(attributes = {}, user)
    review = reviews.build(attributes)
    review.user = user
    review
  end

  def average_rating
    return 'N/A' if reviews.none?
    reviews.average(:rating)
  end
end

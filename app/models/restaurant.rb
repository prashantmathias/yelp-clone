class Restaurant < ActiveRecord::Base
  # has_many :reviews, dependent: :destroy
  validates :name, presence: true, length: { minimum: 3 }, uniqueness: true
  belongs_to :user
  has_many :reviews,
        -> { extending WithUserAssociationExtension },
        dependent: :destroy
  def build_review(attributes = {}, user)
    review = reviews.build(attributes)
    review.user = user
    review
  end
end

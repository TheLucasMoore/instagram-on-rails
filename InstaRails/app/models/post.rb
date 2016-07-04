class Post < ActiveRecord::Base
  has_attached_file :image, styles: { :medium => "640x" }

  validates :image, presence: true
  validates_attachment_content_type :image, :content_type => /\Aimage\/.*\Z/

  validates :user_id, presence: true

  belongs_to :user
  has_many :comments, dependent: :destroy
end

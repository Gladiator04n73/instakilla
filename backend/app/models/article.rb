class Article < ApplicationRecord
  # include Visible

  has_many :comments, dependent: :destroy
  belongs_to :user

  validates :title, presence: true
  validates :body, presence: true, length: { minimum: 10 }

  has_one_attached :photo

  has_many :post_subscriptions, dependent: :destroy
  has_many :subscribers, through: :post_subscriptions, source: :user

  def self.ransackable_attributes(auth_object = nil)
    %w[title body]
  end
end

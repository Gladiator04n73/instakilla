class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_one_attached :photo
  has_many :articles

  has_many :subscriptions, foreign_key: :subscriber_id, dependent: :destroy
  has_many :authors, through: :subscriptions

  has_many :subscribers_subscriptions, class_name: 'Subscription', foreign_key: :author_id, dependent: :destroy
  has_many :subscribers, through: :subscribers_subscriptions, source: :subscrib

  has_many :post_subscriptions, dependent: :destroy
  has_many :subscribed_posts, through: :post_subscriptions, source: :post, class_name: 'Article'
end

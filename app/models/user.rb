class User < ApplicationRecord
  before_save :format_email

  has_many :reviews, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :favorite_movies, through: :favorites, source: :movie

  has_secure_password

  validates :name, presence: true

  validates :email, format: { with: /\A\S+@\S+\z/ },
            uniqueness: { case_sensitive: false }

  validates :password, length: { minimum: 10, allow_blank: true }

  scope :by_name, -> { order(:name) }
  scope :not_admins, -> { by_name.where(admin: false) }

  def format_email
    self.email = email.downcase
  end
end

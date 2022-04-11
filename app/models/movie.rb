class Movie < ApplicationRecord
  has_many :reviews, -> { order(created_at: :desc) }, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :fans, through: :favorites, source: :user
  has_many :characterizations, dependent: :destroy
  has_many :genres, through: :characterizations

  RATINGS = %w[G PG PG-13 R NC-17]

  validates :title, :released_on, presence: true
  validates :description, length: { minimum: 25 }
  validates :total_gross, numericality: { greater_than_or_equal_to: 0 }
  validates :image_file_name,
            format: {
              with: /\w+\.(jpg|png)\z/i,
              message: 'must be a JPG or PNG image',
            }
  validates :rating, inclusion: { in: RATINGS }

  scope :released,
        -> { where('released_on <= ?', Time.now).order(released_on: :desc) }
  scope :upcoming,
        -> { where('released_on > ?', Time.now).order(released_on: :asc) }
  scope :hits,
        -> { where(total_gross: 300_000_000..).order(total_gross: :desc) }
  scope :flops,
        -> { where(total_gross: ...225_000_000).order(total_gross: :asc) }
  scope :recent, ->(max = 5) { order(created_at: :desc).limit(max) }
  scope :past_n_days, ->(days) { where('created_at >= ?', days.days.ago) }
  scope :grossed_less_than, ->(amount) { where('total_gross < ?', amount) }
  scope :grossed_greater_than, ->(amount) { where('total_gross > ?', amount) }
  scope :recently_reviewed,
        ->(max = 10) {
          includes(:reviews).order('reviews.created_at desc').limit(max)
        }

  def flop?
    if reviews.size > 50 && average_stars > 4
      return false
    else
      return total_gross.blank? || total_gross < 225_000_000
    end
  end

  def average_stars
    reviews.average(:stars) || 0.0
  end

  def average_stars_as_percentage
    (average_stars / 5.0) * 100
  end
end

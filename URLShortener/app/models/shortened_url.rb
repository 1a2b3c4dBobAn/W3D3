# == Schema Information
#
# Table name: shortened_urls
#
#  id         :bigint(8)        not null, primary key
#  long_url   :string           not null
#  short_url  :string           not null
#  user_id    :integer          not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class ShortenedUrl < ApplicationRecord
  validates :short_url, :long_url, presence: true, uniqueness: true
  validates :user_id, presence: true

  def self.generate_short_url(options)
    short = SecureRandom::urlsafe_base64

    while ShortenedUrl.exists?(:short_url => short)
      short = SecureRandom::urlsafe_base64
    end

    options['short_url'] = short
    ShortenedUrl.new(options)
  end

  belongs_to :submitter,
  primary_key: :id,
  foreign_key: :user_id,
  class_name: :User

  has_many :visits,
  primary_key: :id,
  foreign_key: :short_url_id,
  class_name: :Visit


  has_many :visitors,
  -> { distinct },
  through: :visits,
  source: :visitor

  has_many :tags_id,
  primary_key: :id,
  foreign_key: :url_id,
  class_name: :Tagging

  has_many :tags,
  through: :tags_id,
  source: :tag

  def num_clicks
    self.visits.count
  end

  def num_uniques
    self.visitors.count
  end

  def num_recent_uniques

    visits = self.visits.where('updated_at > ?', 10.minutes.ago).distinct(:user_id).count

  end
end

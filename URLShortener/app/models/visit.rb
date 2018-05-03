# == Schema Information
#
# Table name: visits
#
#  id           :bigint(8)        not null, primary key
#  visitor_id   :integer          not null
#  short_url_id :integer          not null
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#

# t.integer "visitor_id", null: false
# t.integer "short_url_id", null: false
# t.index ["short_url_id"], name: "index_visits_on_short_url_id"
# t.index ["visitor_id"], name: "index_visits_on_visitor_id"

class Visit < ApplicationRecord
  validates :visitor_id, :short_url_id, presence: true

  belongs_to :visitor,
  primary_key: :id,
  foreign_key: :visitor_id,
  class_name: :User

  belongs_to :linked_to,
  primary_key: :id,
  foreign_key: :short_url_id,
  class_name: :ShortenedUrl

  def self.record_visit! (user, shortened_url)
    Visit.new("visitor_id": user.id, "short_url_id": shortened_url.id).save!
  end

end

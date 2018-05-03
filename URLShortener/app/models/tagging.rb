# == Schema Information
#
# Table name: taggings
#
#  id           :bigint(8)        not null, primary key
#  tag_topic_id :integer          not null
#  url_id       :integer          not null
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#

class Tagging < ApplicationRecord

  belongs_to :tag,
  primary_key: :id,
  foreign_key: :tag_topic_id,
  class_name: :TagTopic

  belongs_to :url,
  primary_key: :id,
  foreign_key: :url_id,
  class_name: :ShortenedUrl
end

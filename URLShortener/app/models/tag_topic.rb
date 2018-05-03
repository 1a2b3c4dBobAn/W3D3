# == Schema Information
#
# Table name: tag_topics
#
#  id         :bigint(8)        not null, primary key
#  tag        :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class TagTopic < ApplicationRecord

  has_many :tagged_url_taggings,
  primary_key: :id,
  foreign_key: :tag_topic_id,
  class_name: :Tagging

  has_many :tagged_url,
  through: :tagged_url_taggings,
  source: :url

  def popular_links
    urls = self.tagged_url

    arr = urls.map do |url|
      [url, url.num_clicks]
    end

    p arr
    arr.sort_by { |el| el[1] }.last
  end
end

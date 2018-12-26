# == Schema Information
#
# Table name: links
#
#  id         :bigint(8)        not null, primary key
#  title      :string
#  url        :string
#  body       :text
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Link < ApplicationRecord
  validates :title, presence: true
  validates :url, presence: true

  def host
    URI(url).host.sub("www.", "")
  end
end

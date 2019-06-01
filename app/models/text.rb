# == Schema Information
#
# Table name: texts
#
#  id           :bigint(8)        not null, primary key
#  title        :string
#  author       :string
#  body         :text
#  published_on :date
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#

class Text < ApplicationRecord
  validates :title, presence: true
  validates :author, presence: true
  validates :body, presence: true
  validates :published_on, presence: true

  def to_param
    [published_on.strftime("%Y"), title.parameterize, id].join("-")
  end
end

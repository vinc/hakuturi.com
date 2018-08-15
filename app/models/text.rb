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
end

class Link < ApplicationRecord
  def host
    URI(url).host
  end
end

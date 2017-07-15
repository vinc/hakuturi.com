class Link < ApplicationRecord
  def host
    URI(url).host.sub("www.", "")
  end
end

module TextsHelper
  class HTMLWithPants < Redcarpet::Render::HTML
    include Redcarpet::Render::SmartyPants
  end

  def markdown_format(text)
    markdown = Redcarpet::Markdown.new(HTMLWithPants)
    markdown.render(text).html_safe
  end
end

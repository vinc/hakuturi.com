module TextsHelper
  class HTMLWithPants < Redcarpet::Render::HTML
    include Redcarpet::Render::SmartyPants
  end

  def markdown_format(source)
    markdown = Redcarpet::Markdown.new(HTMLWithPants)
    markdown.render(source).html_safe
  end

  def render_epub(text)
    html = markdown_format(text.body)

    gbook = GEPUB::Book.new do |book|
      book.identifier = text_url(text)
      book.title = text.title
      book.creator = text.author
      book.language = "en"

      book.ordered do
        item = book.add_item("content.xhtml")
        item.add_content StringIO.new <<~HTML
          <html xmlns="http://www.w3.org/1999/xhtml">
            <head>
              <title>#{text.title}</title>
            </head>
            <body>
              <h2 style="text-align:center">#{text.author} (#{text.published_on.year})</h2>
              <h1 style="text-align:center">#{text.title}</h1>
              #{html}
            </body>
          </html>
        HTML
      end
    end

    gbook.generate_epub_stream.string
  end
end

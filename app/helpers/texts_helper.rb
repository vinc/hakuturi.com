module TextsHelper
  class CustomRender < Redcarpet::Render::HTML
    # include Redcarpet::Render::SmartyPants
    def preprocess(doc)
      doc.gsub("---", "&mdash;").gsub("--", "&ndash;")
    end
  end

  def markdown_format(source)
    markdown = Redcarpet::Markdown.new(CustomRender)
    markdown.render(source).html_safe
  end

  def render_epub(text)
    lang = "en"
    html = <<~HTML
      <?xml version="1.0" encoding="utf-8"?>
      <!DOCTYPE html>
      <html xmlns="http://www.w3.org/1999/xhtml" xmlns:epub="http://www.idpf.org/2007/ops" xml:lang="#{lang}" lang="#{lang}">
        <head>
          <meta content="charset=utf-8"/>
          <title>#{text.title}</title>
        </head>
        <body>
          <h2 style="text-align:center">#{text.author} (#{text.published_on.year})</h2>
          <h1 style="text-align:center">#{text.title}</h1>
          #{markdown_format(text.body)}
        </body>
      </html>
    HTML

    # Markdown conversion may produce HTML entities that are not valid XHTML
    doc = Nokogiri::XML.parse(html)
    xhtml = doc.to_xhtml(indent: 2, encoding: "UTF-8")

    gbook = GEPUB::Book.new do |book|
      book.identifier = text_url(text)
      book.title = text.title
      book.creator = text.author
      book.language = lang

      book.ordered do
        item = book.add_item("content.xhtml")
        item.add_content(StringIO.new(xhtml))
      end
    end

    gbook.generate_epub_stream.string
  end
end

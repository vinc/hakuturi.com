module ApplicationHelper
  def page_meta_tags
    display_meta_tags(
      site: "Hākuturi News",
      separator: "-",
      reverse: true,
      canonical: url_for(only_path: false, locale: nil),
      og: {
        title: :title,
        site_name: :site,
        url: :canonical
      }
    )
  end
end

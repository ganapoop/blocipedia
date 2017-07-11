module WikisHelper

  def markdown(text)
    markdown = Redcarpet::Markdown.new(Redcarpet::Render::HTML, autolink: true, tables: true)
    markdown.render(text).gsub(/^<p>|<\/p>$/, '') 
  end
end

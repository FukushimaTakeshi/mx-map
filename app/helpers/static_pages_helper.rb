module StaticPagesHelper
  class RenderWithoutCode < Redcarpet::Render::HTML; end

  def term
    markdown = Redcarpet::Markdown.new(RenderWithoutCode)
    markdown.render(File.read(Rails.root.join('app/views/static_pages/term.md')))
  end

  def privacy
    markdown = Redcarpet::Markdown.new(RenderWithoutCode)
    markdown.render(File.read(Rails.root.join('app/views/static_pages/privacy.md')))
  end
end

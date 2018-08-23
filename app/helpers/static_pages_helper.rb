module StaticPagesHelper
  class RenderWithoutCode < Redcarpet::Render::HTML
    # def list_item(text, list_type)
    #   case list_type
    #   when :ordered
    #     %(<li class="list-ordered">#{text}</li>)
    #   when :unordered
    #     %(<li class="list-circle">#{text}</li>)
    #   end
    # end
    # def list(contents, list_type)
    #   case list_type
    #   when :ordered
    #     %(<ol class="ordered-list">#{contents}</ol>)
    #   when :unordered
    #     %(<ul class="circle-list">#{contents}</ul>)
    #   end
    # end
  end

  def term
    markdown = Redcarpet::Markdown.new(RenderWithoutCode)
    markdown.render(File.read(Rails.root.join('app/views/static_pages/term.md')))
  end

  def privacy
    markdown = Redcarpet::Markdown.new(RenderWithoutCode)
    markdown.render(File.read(Rails.root.join('app/views/static_pages/privacy.md')))
  end
end

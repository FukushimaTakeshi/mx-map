module PrefecturesHelper
  def half_or_full_star(decimal_part)
    case decimal_part
    when 3, 4, 5, 6, 7
      content_tag(:span, '', class: ['icon', 'mdi-18px', 'has-text-success']) do
        content_tag(:i, '', class: ['fas', 'fa-star-half'])
      end
    when 8, 9
      content_tag(:span, '', class: ['icon', 'mdi-18px', 'has-text-success']) do
        content_tag(:i, '', class: ['fas', 'fa-star'])
      end
    end
  end
end

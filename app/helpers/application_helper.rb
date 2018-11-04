module ApplicationHelper
  def default_meta_tags
    {
      site:        Settings.meta.name,
      charset:     'utf-8',
      reverse:     true,
      title:       Settings.meta.title,
      description: Settings.meta.description,
      keywords:    Settings.meta.keywords,
      canonical:   request.original_url,
      index:       true,
      follow:      true,
      icon: [
        { href: image_url('favicon.ico') },
        # { href: image_url('icon.jpg'), rel: 'apple-touch-icon', sizes: '180x180', type: 'image/jpg' },
      ],
      og: {
        title:       :title,
        type:        Settings.meta.og.type,
        url:         request.original_url,
        # image:       '',
        site_name:   :site,
        description: :description,
        locale:      'ja_JP'
      }
    }
  end
end

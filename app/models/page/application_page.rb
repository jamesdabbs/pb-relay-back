module Page
  module ApplicationPage
    Templates = {}

    def render name
      path = Rails.root.join('app', 'views', 'pages', "#{name}.md.erb").to_s
      Templates[path] ||= ERB.new(File.read(path))

      Templates[path].result(binding)
    end
  end
end

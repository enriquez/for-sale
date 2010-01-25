class WebAppThemeGenerator < Rails::Generator::NamedBase
  default_options :skip_stylesheets => false, :skip_partials => false, :layout_only => false

  def manifest
    @layout = name
    @theme = actions.first || 'default'
    record do |m|
      # Layouts
      m.directory('app/views/layouts')
      m.template(
        'layout.html.erb',
        "app/views/layouts/#{@layout}.html.erb",
        :assigns => { :layout => @layout, :theme => @theme }
      )
      
      unless options[:layout_only]
        
        unless options[:skip_stylesheets]
          # Stylesheets
          m.directory('public/stylesheets/web_app_theme')
          m.file(
            'base.css',
            'public/stylesheets/web_app_theme/base.css',
            :collision => :skip
          )
          m.file(
            "#{@theme}/style.css",
            "public/stylesheets/web_app_theme/#{@theme}.css",
            :collision => :skip
          )
        end
        
        unless options[:skip_partials]
          # Partials
          m.directory('app/views/web_app_theme')
          m.file(
            '_main_block.html.erb',
            'app/views/web_app_theme/_main_block.html.erb',
            :collision => :skip
          )
          m.file(
            '_sidebar_block.html.erb',
            'app/views/web_app_theme/_sidebar_block.html.erb',
            :collision => :skip
          )
        end
        
      end
      
    end
  end
  
  protected
  def banner
    "Usage: #{$0} web_app_theme layout theme"
  end
  
  def add_options!(opt)
    opt.separator ''
    opt.separator 'Themes:'
    opt.separator "bec, bec-green, blue, default, djime-cerulean, drastic-dark, kathleene, orange, reidb-greenish"
    opt.separator ''
    opt.separator 'Options:'
    opt.on("-l", "--skip_stylesheets",
           "Don't add the web app theme stylesheets.") { |v| options[:skip_stylesheets] = v }
    opt.on("-a", "--skip_partials",
           "Don't add the web app theme partials.") { |v| options[:skip_partials] = v }
    opt.on("-y", "--layout_only",
           "Don't add the web app theme stylesheets or partials.") { |v| options[:layout_only] = v }
  end
end
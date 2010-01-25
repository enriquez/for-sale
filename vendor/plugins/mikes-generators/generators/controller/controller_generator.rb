module MikesGenerators
  class ControllerGenerator < Rails::Generator::NamedBase
    default_options :include_base_controller => false
  
    def manifest
      record do |m|
        # Check for class naming collisions.
        m.class_collisions "#{class_name}Controller", "#{class_name}ControllerTest", "#{class_name}Helper", "#{class_name}HelperTest"

        # Controller, helper, views, and test directories.
        m.directory File.join('app/controllers', class_path)
        m.directory File.join('app/helpers', class_path)
        m.directory File.join('app/views', class_path, file_name)
        m.directory File.join('test/functional', class_path)
        m.directory File.join('test/unit/helpers', class_path)

        # Controller class, functional test, and helper class.
        m.template 'controller.rb',
          File.join('app/controllers',
            class_path,
            "#{file_name}_controller.rb")

        m.template 'functional_test.rb',
          File.join('test/functional',
            class_path,
            "#{file_name}_controller_test.rb")

        m.template 'helper.rb',
          File.join('app/helpers',
            class_path,
            "#{file_name}_helper.rb")

        m.template 'helper_test.rb',
          File.join('test/unit/helpers',
            class_path,
            "#{file_name}_helper_test.rb")
      
        if class_nesting.present? && options[:include_base_controller]
          m.template 'base_controller.rb',
            File.join('app/controllers',
              class_path,
              "base_controller.rb"),
            :collision => :skip
        end
      
        # View template for each action.
        actions.each do |action|
          path = File.join('app/views', class_path, file_name, "#{action}.html.erb")
          m.template 'view.html.erb', path,
            :assigns => { :action => action, :path => path }
        end
      end
    end
  
    protected
    def add_options!(opt)
      opt.separator ''
      opt.separator 'Options:'
      opt.on("-b", "--include_base_controller",
             "Create the base controller for namespaced controller.") { |v| options[:include_base_controller] = v }
    end
    
  end
end
require "tty-spinner"
require 'swaggerator/logger'
require 'tty-table'
require 'terminal-table'

namespace :swaggerator do
  desc "Checks if configuration is defined"

  task check: :environment do 
    puts Swaggerator::Config.open_api_version
  end
  desc "Generate a swagger.json file based on the definition file"

  task generate: :environment do 
    
    
    data = YAML.load_file('swag/define.yml')


    response = Swaggerator::Renderer.render(data)

    open("swag/swagger.json", 'w') { |f| f << response.to_json }

  end
  desc "Generate or update a define.yml file based on the routes in the application"

  task define: :environment do
    spinner = TTY::Spinner.new
    spinner.auto_spin
    data = Swaggerator::Integrator.get_definition
    spinner.stop("Done")
    dir = "swag"
    Dir.mkdir(dir) unless Dir.exists?(dir)
  

    if(File.exist?("swag/define.yml") )
      loaded_data = YAML.load_file('swag/define.yml')
      paths_added= 0
      methods_added =0

      data.each do |path, path_data|

        if(loaded_data[path].present?)
          path_data.each do |verb, verb_data|
            if(loaded_data[path][verb].present?)
            # do nothing
            else
              methods_added = methods_added +1

              loaded_data[path][verb] = data[path][verb]
            end
          end
        else
          paths_added = paths_added + 1
          loaded_data[path] =  data[path]

        end


      end

      open("swag/define.yml", 'w') { |f| f << loaded_data.to_yaml }
      puts "Paths added: #{paths_added} "
      puts "Methods added: #{methods_added} "

      errors= Swaggerator::Logger.get
      if(errors.present?)

        puts 
        puts "Errors:"
        #puts errors
       
        rows= []
        rows<<["Module", "Source", "Errors"]
        errors.map{|erro| 
          rows<<erro
        }
        table = Terminal::Table.new :rows => rows

        puts table
      end

    else 
      open("swag/define.yml", 'w') { |f| f << data.to_yaml }

    end


 
  end

end

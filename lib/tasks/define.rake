namespace :swaggerator do
  desc "Generate a swagger file based on the routes file"

  def render(obj)
  	response = { paths: {},
  	 openapi: "3.0.0",
  	 info: {title: "Sample API",
  	 description: "Stubbed",
  	 version: "0.1.9"}, 
  	 }
  	obj.each do |path, path_content|
  		path_response={}

  			path_content.each do |method_name, method_content|
  				method_response= {}
  				method_response[:responses] = {}
  				method_response[:responses]['200']= {description: "Stubbed"}

          method_response[:parameters]= []
  				method_content[:route_params].each do | route_param|

  					method_response[:parameters] = method_response[:parameters] || []
  					param_response={
  						in: :path,
  						name: route_param,
  						required: true,
  						description: route_param.humanize,
  						schema: {type: "string"}

  					}
  					method_response[:parameters] << param_response
  				end


  				path_response[method_name]= method_response
  				
  			end
  		response[:paths][path]= path_response

  	end
  	response
  end

  task generate: :environment do 
    data = YAML.load_file('swag/define.yml')
    response = Swaggerator::Renderer.render(data)

    open("swag/swagger.json", 'w') { |f| f << response.to_json }

  end
  task definition: :environment do

    data = Swaggerator::Integrator.get_definition


    if(File.exist?("swag/define.yaml") && false)
      loaded_data = YAML.load_file('swag/define.yaml')
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

    else 
      open("swag/define.yml", 'w') { |f| f << data.to_yaml }

    end


 
  end

end

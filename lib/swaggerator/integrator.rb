require 'swaggerator/helpers/routes_enhancer'
require 'swaggerator/helpers/routes_grouper'
require 'swaggerator/helpers/routes_loader'
require 'swaggerator/enricher'
require 'swaggerator/helpers/definition_cleaner'
module Swaggerator
	class Integrator
		##Loads the route inspector depending on the rails version. 

		def self.get_definition
			routes = Helpers::RoutesLoader.extract_routes
			routes = Helpers::RoutesEnhancer.enhance(routes)
			routes = Enricher.enrich(routes)
			routes = Helpers::DefinitionCleaner.clean(routes)
			routes = Helpers::RoutesGrouper.group(routes)

			return  routes
			
		end

	

		def self.seggregate(grouped_data)

		split_data = {}
		grouped_data.dup.each do |key,value|
		  #ignored_parts = [/^api/, /^v[0-9\.]+/ ]
		  thepath=key.sub /^\//, '' #remove leading slash from path i.e /users/:id to users/:id

		  path_parts = thepath.split(/\//)
		  size = path_parts.size
		  group = path_parts[0] if size>1

		  omission_index = size -2
		  rejected_indices =[]
		  path_parts.each_with_index do |part, ind|
		    puts "Checking part #{part}"
		    if(/^:/.match(part) )
		    puts "-- Rejecting part #{part}"

		      rejected_indices << ind
		      rejected_indices << ind+1 if ind < (size - 1)
		    end

		  
		  end

		  rejected_indices.each do |index|
		    path_parts.delete_at(index)
		  end

		  group = path_parts[(0..omission_index)].join("_")

		  split_data[group]= split_data[group] || []
		  split_data[group].push(value)
		end
		split_data.deep_stringify_keys!
		keys = split_data.keys

		keys.map do |key|
		  open("swag/#{key}.yaml", 'w') { |f| f << {"group"=> key.to_s, "data"=> split_data[key]}.to_yaml }

		end
		#open('output.json', 'w') { |f| f << JSON.pretty_generate(render(grouped_data)) } 
	  end
		
	end

end
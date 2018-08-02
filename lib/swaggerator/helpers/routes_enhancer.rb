module Swaggerator
	module Helpers
		class RoutesEnhancer
		## Enhance Routes with additional Information

			def self.enhance(routes)

			    routes.map{ |r| 

			    	r[:path].sub! /\(\.:format\)/,'' 
			    	r[:route_params] =  r[:path].scan(/:[^\/]+/)
			    	r[:summary] =r[:name].humanize || r[:path].humanize
			      	r[:description] = r[:summary]
			    	#r[:responses]= {}
			    	#r[:responses]['200']=[]
			    	#r[:responses]['200']<< { description: 'Stubbed' }
			    	#r[:parameters]= []
			    	r[:executioner]=r[:reqs][/^([^ ]+)/]
			    	begin

				    	execution_path = r[:executioner]
						controller,action = execution_path.split("#")
						controller = controller + "_controller"
						controller_class = controller.camelize.constantize
						r[:source_code] = controller_class.instance_method(action).source
						r[:controller_class] = controller_class
					rescue NameError=>ex
						r[:source_code] = nil
					end

					# r[:route_params].each do |route_param|

						
					# 	r[:parameters] << {
					# 		in: :path,
					# 		name: route_param,
					# 		required: true,
					# 		description: route_param.humanize,
					# 		summary: route_param.humanize,
					# 		schema: {type: "string"},

					# 	}
					# end

						#self.enrich(r)


			    }
			    return routes

			end		
		end
	end
end
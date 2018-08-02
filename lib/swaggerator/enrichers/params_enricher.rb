require "swaggerator/helpers/routes_mapper"
module Swaggerator
	module Enrichers
		class ParamsEnricher

			def self.enrich(routes)
				routes.map do |route|

						#puts "runnign source Params enricher"
						source_code = route[:source_code]
						#puts "Source: #{route}"
						next if !source_code
						#puts "runnign source Params enricher; level 2"

						controller_class =route[:controller_class]
						extractor= Swaggerator::Extractors::ParamsExtractor.new(source_code)
						extractor.detect_param_method_fields(controller_class)
						functional_params = extractor.param_fields
						field_name = route[:verb].downcase.to_sym == :get ? :query_params : :body_params
						route[field_name]= codify(functional_params)
						 
#						puts "ParamsEnricher threw an #{e} except while processing #{route[:path] }:  #{route[:verb]}"
					
				end
				routes
			end

			def self.codify(functional_params)

			
				functional_params.map do |param|
					#puts "#{param} : #{param.class}"
					definition = nil
					if(param.is_a?(Symbol) || param.is_a?(String) )
						definition= {
							name: param,
							description: param.to_s.humanize,
							type: "string",
						} 
					end
				
					if(param.is_a? Hash)
						key = param.keys.first
						definition = {
							name: param,
							description: param.to_s.humanize,
							type: "object",
							properties:[],
						}
						param[key].each do |val|
							definition[:properties]<<{
								name: val,
								description: val.to_s.humanize,
								type: "string",
							}
							
						end
						

					end
					definition
				end
			
			end
		end
	end
end
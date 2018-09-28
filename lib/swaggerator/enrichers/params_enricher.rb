require "swaggerator/helpers/routes_mapper"
require "swaggerator/helpers/params_codifier"
module Swaggerator
	module Enrichers
		class ParamsEnricher

			def self.enrich(routes)
				routes.map do |route|
					source_code = route[:source_code]
					next if !source_code
					controller_class =route[:controller_class]
					begin
						extractor= Swaggerator::Extractors::ParamsExtractor.new(source_code)
						extractor.detect_param_method_fields(controller_class)
						functional_params = extractor.param_fields
						field_name = route[:verb].downcase.to_sym == :get ? :query_params : :body_params
						route[field_name]= Swaggerator::Helpers::ParamsCodifier.codify(functional_params)	
	
					rescue =>e						
						Swaggerator::Logger.push ["ParamsExtractor", "#{controller_class.name}###","#{e}"]

					end
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
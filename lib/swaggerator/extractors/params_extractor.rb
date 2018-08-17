require "swaggerator/extractors/params_method_parser"
module Swaggerator
	module Extractors
		class ParamsExtractor
			PARAM_SCANNER_REGEX= /\b([A-Za-z0-9_\.]*params)\b(\[[^\]]+\])*/
			attr_accessor :param_fields, :parameters_detected
			
			def initialize(method_source)
				params_matches = method_source.scan(PARAM_SCANNER_REGEX)
				parameter_methods_detected = {
					
				}
				@parameters_detected={}
				@param_fields= []
				params_matches.map do |param_match|
					param_name = param_match[0]
					@parameters_detected[param_name]||=[]
					@parameters_detected[param_name]<< eval(param_match[1])[0].to_s if param_match[1]
					@parameters_detected[param_name].uniq!
				end

				if(@parameters_detected['params'])
					@parameters_detected['params'].each do |param_field|
						@param_fields << param_field
					end
				end
				@parameters_detected.delete('params')
				@param_fields.map!(&:to_s)
			end

			def detect_param_method_fields(controller_class)
				parameters_detected.keys.each do |parameter|
					begin
						the_method = controller_class.instance_method(parameter)
						source_code = the_method.source
						source_code = source_code.split("\n").tap{|x| x.shift; x.pop}.join("\n")
						#puts "PARSED PARAMS",parser(source_code).params
						@param_fields+=parser(source_code).params

					rescue =>e
						puts e
					end

				end
			end

			def parser(source_code)
				Swaggerator::Extractors::ParamsMethodParser.new(source_code)

			end



		end

	end
end
module Swaggerator
	module Helpers
		class ParamsCodifier 

			def self.codify(params, name=nil)
				puts "PARAMS_GROUP", params.inspect
				if(params.is_a? Hash)
					return codify(params[params.keys.first])
				end
				params.map do |param|
					# puts "*"*30
					 puts "PARAM", param.inspect
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
						puts "#"*20
						puts "KEY", key
						puts "DATA", param[key].inspect
						#puts "Codified", self.codify(param[key]).inspect
						definition = {
							name: key,
							description: key.to_s.humanize,
							type: "object",
							properties: self.codify(param[key]).index_by { |d| d[:name]}.tap{|x| x.each{|key,value| value.delete(:name)}} ,
						}
				
						
						puts "#"*20
					end
					definition
					#puts "*"*30

				end

			end#Codify
		end
	end
end

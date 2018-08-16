module Swaggerator
	module Helpers
		class ParamsCodifier 

			def self.codify(params)
				params.map do |param                                                    |
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
							name: key,
							description: key.to_s.humanize,
							type: "object",
							properties: self.codify(param[key]).index_by { |d| d[:name]}.tap{|x| x.each{|key,value| value.delete(:name)}} ,
						}
				
						

					end
					definition
				end
			
			end#Codify
		end
	end
end

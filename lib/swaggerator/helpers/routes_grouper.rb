module Swaggerator
	module Helpers
		class RoutesGrouper

			def self.group(routes)

				data = routes.group_by{|d| d[:path]}
				data.each do |path, verbs_array|
					data[path]= verbs_array.map do |verb_data|
				 		verb_data.delete(:path)
						verb_data
					end
				end
			    data.dup.each do |key,value|
			    	data[key]= value.index_by{|x| x[:verb].downcase}
			    	data[key].each do |verb, verb_data|
				 		verb_data.delete(:path)
			    		verb_data.delete(:verb)
			    	end
			    end
			    data
			end
		end
	end
end
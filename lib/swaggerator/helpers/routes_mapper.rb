module Swaggerator
	module Helpers
		class RoutesMapper
		## Provide map over the routes definition hash

			def self.map(routes)
				routes.each do |path, value|
					value.each do |verb, data|
						yield (data) if block_given?
					end
				end

			end		
		end
	end
end

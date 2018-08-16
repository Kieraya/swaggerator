module Swaggerator
	module Enrichers
		class TagsEnricher
			def self.enrich(routes)

				routes.map do |route|
					components = route[:path].split(/\//)
					components.reject!{|c| c=~/:/||/^api/=~c||  /v\d+/ =~c || c.blank? }
					route[:tags]=components.map(&:singularize)
					route
				end


			end
		end
	end
end

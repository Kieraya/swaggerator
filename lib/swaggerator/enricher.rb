require "swaggerator/enrichers/params_enricher"
module Swaggerator
	REGISTERED_ENRICHERS=[Swaggerator::Enrichers::ParamsEnricher]
	class Enricher

		def self.enrich(routes)

			REGISTERED_ENRICHERS.each do |the_enricher|
				the_enricher.enrich(routes)

			end
			return routes

		end
	end
end

require "swaggerator/enrichers/params_enricher"
require "swaggerator/enrichers/tags_enricher"

module Swaggerator
	REGISTERED_ENRICHERS=[Swaggerator::Enrichers::ParamsEnricher,Swaggerator::Enrichers::TagsEnricher]
	class Enricher

		def self.enrich(routes)

			REGISTERED_ENRICHERS.each do |the_enricher|
				the_enricher.enrich(routes)

			end
			return routes

		end
	end
end

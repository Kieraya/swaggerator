module Swaggerator
	# woooh. Super advanced controller simulator
	module Mockers
		class ActionControllerSimulator

			def initialize
				@params= Swaggerator::Mockers::ActionParamInterceptor.new 
			end

			def params 
				@params
			end

		end
	end
end
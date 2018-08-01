module Swaggerator
	module Mockers
		class ActionParamInterceptor
			attr_reader :callstack

			def initialize
				@callstack= []

			end

			# This is one of the few good uses of method_misisng
			# Overzealous programmers tend to overuse this to show off 
			# Their Reflection skills and make searching for code a pain
			# for everyone
			def method_missing(name, *args, &block)
				@callstack << {name: name, args: args}
				## Ignore the block given cuz we can't really do much with it

			end

			
		end
	end
end

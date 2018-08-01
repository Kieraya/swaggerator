module Swaggerator
	module Extractors
		class ParamsMethodParser
			def self.yield_lambda(source_code)
				return eval "Proc.new {#{source_code}}"

			end
			def initialize(source_code)
					#  Execute the method in the context of the mock controller
					#  which overrides the params method'
					mock_controller = Swaggerator::Mockers::ActionControllerSimulator.new
					the_lambda=self.class.yield_lambda(source_code)
					mock_controller.instance_eval &the_lambda
					callstack = mock_controller.params.callstack
					@callstack = callstack
					callstack.select!{|pcall| [:permit, :require].include? pcall[:name]}
					@input_params = []

					case callstack.length
					
						when 1
							elem = callstack[0]
							args = elem[:args]
							args =args[0] if(args.count == 1) && (args[0].is_a? Array)

							@input_params+= args


						when 2
							first_method = callstack[0][:name] 
							case first_method 
								when :require, :permit
									obj_name = callstack[0][:args][0]
									obj_params = callstack[1][:args][0].is_a? Array ? callstack[1][:args][0] : callstack[1][:args]  
									args =args[0] if(args.count == 1) && (args[0].is_a? Array)

									@input_params<<{obj_name=>obj_params}
							end
					end
					
					#End Case

			end


			
			def params 
				@input_params
			end
		end
	end
end

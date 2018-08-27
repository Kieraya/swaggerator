module Swaggerator
    class Logger
       @@logs= []
        def self.push(str)
            @@logs.push(str)

        end

        def self.get
            return @@logs
        end
    end
end
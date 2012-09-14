module Mutant
  module Examples
    
    class Counter
      
      attr_reader :counter
      
      def initialize(start=0)
        @counter = start
      end
      
      def increment(size=1)
        @counter = @counter + size
      end
      
    end
     
  end
end
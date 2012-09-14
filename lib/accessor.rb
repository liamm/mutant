module Mutant
  
  class Accessor
    
    def initialize(object)
      @write_mutex = Mutex.new
      @read_mutex  = Mutex.new
      
      @object = object
      update
    end
    
    def update
      @write_mutex.synchronize do
        yield @object if block_given?
        
        @read_mutex.synchronize { @immutable_copy = @object.dup }
      end
    end
    
    def read
      @read_mutex.synchronize { yield @immutable_copy if block_given? }
    end
    
    def method_missing(m, *args, &block) 
      read(&m)
    end
        
  end
  
end

module Mutant
  
    class Hash
      
      class NonEnumerableHash < Exception; end
      
      def initialize
        @mutex = Mutex.new
        @hash = {} # can be passed defaults as normal Hash would be?
      end
      
      def []= key, value
        @mutex.synchronize { @hash[key] = Mutant::Accessor.new(value) }
      end
      
      def [] key
        @mutex.synchronize { @hash[key] }
      end
      
      def keys
        @mutex.synchronize { @hash.keys }
      end
      
      def values
        @mutex.synchronize { @hash.values }
      end
      
      def clear
        @mutex.synchronize { @hash = ::Hash.new }
      end
      
      def each
        raise NonEnumerableHash, "Cannot iterate directly on Mutant::Hash, please iterate over the keys, values, or by using the each_pair method"
      end
      
      def each_pair
        collection = []
        @mutex.synchronize do
          collection << @hash.keys << @hash.values
        end
        
        length = collection.length / 2
    
        length.times do |i|
          yield collection[i], collection[i+length]
        end
      end
      
    end
  
end
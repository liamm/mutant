=======
Mutant
======

The aim of Mutant is to provide a threadsafe layer on top of various Ruby collections by introducing an object accessor that provides a read-only immutable copy of any given object.

Mutant is ideal in situations where updating an in-memeory object can take a while, but using a read-only copy of the object is sufficient.

The performance cost of using Mutant will only really be noticed when the object is expensive to 'dup'.  There will also be a slight performance hit as Mutant uses a Mutex to ensure thread-safety, which is common in most threadsafe libraries.

Example:

```ruby
class Counter
  
  attr_reader :counter
  
  def initialize(start=0)
    @counter = start
  end
  
  def increment(size=1)
    @counter = @counter + size
  end
  
end

counter = Mutant::Hash.new

counter[:key] = Counter.new
t = Thread.new do 
  100.times do
    Thread.new do
      counter[:key].update(&:increment)
    end
  end
end

t.join
```

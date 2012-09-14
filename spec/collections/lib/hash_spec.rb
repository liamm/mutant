require 'mutant'
require 'support/counter'

describe "Examples" do
  
  subject { Mutant::Hash.new }
  
  let(:counter) { Mutant::Examples::Counter.new }
  let(:repeat) { 10000 }
  
  it "should mantain a correct count when incrementing" do
    subject[:counter] = counter
    t = Thread.new do 
      repeat.times do
        Thread.new { subject[:counter].update(&:increment) }
      end
    end
    
    t.join
    
    subject[:counter].counter.should == repeat
  end
  
  it "not threadsafe - *probably* won't mantain a correct count when incrementing" do
    
    t = Thread.new do
      repeat.times do
        Thread.new { counter.increment }
      end
    end
    
    t.join
    
    #p counter.counter
  end
  
end
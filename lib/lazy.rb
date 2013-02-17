# heavily modified from original source:
# http://www.innig.net/software/ruby/closures-in-ruby

# changes: uses BasicObject so that #send gets passed to the reference

class Lazy < BasicObject
  def initialize(&ref)
    @__lazy_reference = ref
  end

  def send(method, *args, &block)
    __send__(method, *args, &block)
  end

  def __send__(method, *args, &block)
    @__lazy_reference.call.send(method, *args, &block)
  end

  def method_missing(method, *args, &block)
    @__lazy_reference.call.send(method, *args, &block)
  end
end

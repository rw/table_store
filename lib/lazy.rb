# modified from source: http://www.innig.net/software/ruby/closures-in-ruby

class Lazy
  def initialize(&ref)
    @ref = ref
  end

  def method_missing(method, *args, &block)
    fetch.send(method, *args, &block)
  end

  def respond_to?(method)
    fetch.respond_to?(method)
  end

  def fetch
    @ref.call
  end
end

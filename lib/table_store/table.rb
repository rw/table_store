module TableStore
  class Table < Hash
    class DuplicateKeyError < RuntimeError; end

    def []=(key, value)
      super(key, value)

      resort_keys!

      value
    end

    def [](key)
      Lazy.new { super(key) }
    end

    def keys
      @sorted_keys ||= super.sort
    end

    def resort_keys!
      @sorted_keys = nil
      keys
    end
  end
end

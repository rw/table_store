require 'lib/lazy'

module TableStore
  class Table < Hash
    class DuplicateKeyError < RuntimeError; end

    def []=(key, value)
      raise DuplicateKeyError.new(key) if has_key? key

      super(key, value)

      resort_keys!

      value
    end

    def ref(key)
      Lazy.new { self[key] }
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

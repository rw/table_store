require 'lib/lazy'

module TableStore
  class Table
    class DuplicateKeyError < RuntimeError; end

    def initialize
      @rows = {}
    end

    def rows
      @rows
    end

    def insert(key, value)
      raise DuplicateKeyError.new(key) if rows.include? key

      rows[key] = value
    end

    def get(key)
      rows[key]
    end

    def ref(key)
      Lazy.new { get(key) }
    end

    def indices
      rows.keys
    end

    def empty?
      rows.empty?
    end
  end
end

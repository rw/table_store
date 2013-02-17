# TableStore

TableStore is an in-memory relational data store. Create tables, and references between them, as if you were using a regular database. By using lazy evaluation, references to other tables will always show the latest values.
## Installation

Add this line to your application's Gemfile:

    gem 'table_store'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install table_store

## Usage

Create two tables:

    require 'table_store'
    
    things = TableStore::Table.new
    colors = TableStore::Table.new
    
Create an object that references one of those tables. Here, the `authors` table is referenced twice:

    stop_sign = {:color => colors['red']}
    things['stop_sign'] = stop_sign
    
Because lookup is lazy under the hood, this returns whatever is currently at `colors[:color]`:

    stop_sign[:color]
    => nil
    
When changing the value of `colors['red']`, `stop_sign` sees the change:

    colors['red'] = 'a bright color'
    stop_sign[:color]
    => 'a bright color'

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request

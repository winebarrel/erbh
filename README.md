# ERBh

Simple ERB helper.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'erbh'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install erbh

## Usage

```ruby
require 'erbh'
include ERBh

erbh('<%= @foo %>, <%= @bar %>', foo: 100, bar: 'zoo')
#=> "100, zoo"

erbh(<<-EOS, {foo: 1..3}, trim_mode: '-')
<%- @foo.each do |i| -%>
<%= i %>
<%- end -%>
EOS
#=> "1\n2\n3\n"
```

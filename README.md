# ERBh

Simple ERB helper.

[![Build Status](https://travis-ci.org/winebarrel/erbh.svg?branch=master)](https://travis-ci.org/winebarrel/erbh)

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

### Define helper method

```ruby
require 'erbh'
include ERBh

ERBh.define_method(:concat) {|a, b| a + b }

erbh('<%= concat @foo, @bar %>', foo: 'a', bar: 'b')
#=> "ab"

ERBh.define_method(:chomp) do |obj|
  if obj.nil?
    @_erbout.sub!(/,\s*\z/, '')
    ''
  else
    obj
  end
end

erbh('100, <%= chomp @foo %>', foo: nil)
#=> "100"
```

# frozen_string_literal: true

require 'erb'

module ERBh # rubocop:disable Style/Documentation
  @methods = {}

  @default_options = {
    trim_mode: '-',
    eoutvar: '_erbout'
  }

  def self.define_method(name, &block)
    @methods[name] = block
  end

  def self.default_options
    @default_options
  end

  def self.erbh_methods
    @methods
  end

  def erbh(str, variables = {}, options = {})
    options = ERBh.default_options.merge(options)
    context = Object.new

    variables.each do |name, value|
      context.instance_variable_set("@#{name}", value)
    end

    class << context
      ERBh.erbh_methods.each do |name, block|
        define_method(name, block)
      end
    end

    context.instance_eval do
      erb = ERB.new("<% @#{options[:eoutvar]} = #{options[:eoutvar]} %>\n" + str, **options)
      erb.result(binding).sub(/\A\n/, '')
    end
  end
  module_function :erbh
end

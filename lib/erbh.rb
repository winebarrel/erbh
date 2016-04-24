require 'erb'

module ERBh
  @@methods = {}

  @@default_options = {
    :safe_level => nil,
    :trim_mode => '-',
    :eoutvar => '_erbout',
  }

  def self.define_method(name, &block)
    @@methods[name] = block
  end

  def self.default_options
    @@default_options
  end

  def erbh(str, variables = {}, options = {})
    options = @@default_options.merge(options)
    context = Object.new

    variables.each do |name, value|
      context.instance_variable_set("@#{name}", value)
    end

    class << context
      @@methods.each do |name, block|
        define_method(name, &block)
      end
    end

    context.instance_eval do
      erb = ERB.new("<% @#{options[:eoutvar]} = #{options[:eoutvar]} %>\n" + str, *options.values_at(:safe_level, :trim_mode, :eoutvar))
      erb.result(binding).sub(/\A\n/, '')
    end
  end
  module_function :erbh
end

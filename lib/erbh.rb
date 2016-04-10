require 'erb'

module ERBh
  def erbh(str, variables = {}, options = {})
    options = {
      :safe_level => nil,
      :trim_mode => nil,
      :eoutvar => '_erbout',
    }.merge(options)

    context = Object.new

    variables.each do |name, value|
      context.instance_variable_set("@#{name}", value)
    end

    context.instance_eval do
      erb = ERB.new(str, *options.values_at(:safe_level, :trim_mode, :eoutvar))
      erb.result(binding)
    end
  end
  module_function :erbh
end

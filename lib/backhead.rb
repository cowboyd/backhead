require "backhead/version"
require 'active_support/concern'
require 'rails/engine'

module Backhead
  extend ActiveSupport::Concern

  included do
    fail TypeError, "Backhead can only be included into subclasses of Rails::Railtie" unless self < Rails::Railtie
  end

  module ClassMethods
    def configuration(name, &block)
      options = @_current_configuration_options = Set.new
      yield if block_given?
      struct = Struct.new(*options.to_a).new
      config.send("#{name}=", struct)
      initializer "#{name}.setup" do |app|
        options.each do |option|
          if struct.send(option).nil?
            struct.send("#{option}=", ENV["#{name}_#{option}".upcase])
          end
        end
      end
    end

    def option(name)
      @_current_configuration_options << name.to_sym
    end
  end
end

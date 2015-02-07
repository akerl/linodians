require 'open-uri'
require 'cymbal'

module Linodians
  ##
  # Employee object
  class Employee
    def initialize(params = {})
      @data = Cymbal.symbolize params
    end

    def photo
      @photo ||= open(PHOTO_URL % username) { |x| x.read }
    end

    def [](value)
      @data[value.to_sym]
    end

    def to_json(*args, &block)
      @data.to_json(*args, &block)
    end

    def respond_to?(method, _ = false)
      @data.key?(method) || super
    end

    def to_h
      @data.dup
    end

    private

    def method_missing(method, *args, &block)
      return super unless @data.key?(method)
      instance_eval "def #{method}() @data[:'#{method}'] end"
      send(method)
    end
  end
end

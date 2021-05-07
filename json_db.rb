require 'json'
require 'active_support/inflector'

class JsonDb
  
  def initialize(json_filename)
    @json_filename = json_filename
  end

  attr_reader :json_filename
  
  def data
    @data ||= JSON.parse(IO.read(json_filename))
  end
  
  private
  
  # Use this method to store updated properties on disk
  def serialize
    IO.write(json_filename, data.to_json)
  end

  def method_missing(method_name, *_args)
    value = data[method_name.to_s]

    if value.is_a? Array
      value.map { |params| @class ||= ActiveSupport::Inflector.safe_constantize(ActiveSupport::Inflector.singularize(method_name).capitalize).new(params: params) }
    else
      value
    end
  end
end

class Employee
  attr_accessor :first_name, :last_name

  def initialize(params:)
    @first_name = params['first_name']
    @last_name = params['last_name']
  end
end

class Company
  attr_accessor :name, :location, :employees

  def initialize(params:)
    @name = params['name']
    @location = params['location']
    @employees = params['employees'].map { |employee| Employee.new(params: employee) }
  end
end

require 'rack'
require 'hoodoo'
require_relative 'validate_service.rb'

class ValidateService < Hoodoo::Services::Service
  comprised_of ValidateInterface
end

# This is a hack for the example and needed if you have Active Record present, else Hoodoo will expect a database connection.
Object.send( :remove_const, :ActiveRecord ) rescue nil

# Tell rack to use the thin webserver on port 9292
builder = Rack::Builder.new do
  use( Hoodoo::Services::Middleware )
  run( ValidateService.new )
end

Rack::Handler::Thin.run( builder, :Port => 9292 )
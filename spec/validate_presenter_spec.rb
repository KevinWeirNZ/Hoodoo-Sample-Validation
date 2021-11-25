require 'spec_helper'
require_relative '../validate_service.rb'
require 'json_spec'

describe "validate service" do

  describe PresenterClass do

    it "passes if input data conforms to the schema" do
      data = { 'first_name' => 'John','surname' => 'Smith' } # Create a set of dummy data.
      rendered = PresenterClass.render( data )               # Render the data so defaults can be applied properly so that it can be validated.
      validation_errors = PresenterClass.validate( rendered )
      expect( validation_errors.has_errors? ).to eql false
    end

    it "passes if input data does not conform to the schema" do
      data = { 'first_name' => 'John' }                      # Create a set of dummy data.
      rendered = PresenterClass.render( data )               # Render the data so defaults can be applied properly so that it can be validated.
      validation_errors = PresenterClass.validate( rendered )
      expect( validation_errors.has_errors? ).to eql ( true )
    end

    it "checks the error message is correct" do
      data = { 'first_name' => 'John' }
      rendered = PresenterClass.render( data )
      validation_errors = PresenterClass.validate( rendered )
      error_msg = [{
        "code"      => "generic.required_field_missing",
        "message"   => "Field `surname` is required",
        "reference" => "surname"
      }]
      expect( validation_errors.errors ).to eql( error_msg )
    end
  end
end

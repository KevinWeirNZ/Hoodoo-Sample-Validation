require 'spec_helper'
require_relative '../validate_service.rb'

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

  end
end
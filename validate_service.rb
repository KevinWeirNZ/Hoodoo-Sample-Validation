require 'hoodoo'

class ValidateImplementation < Hoodoo::Services::Implementation
  def create( context )
    body = context.request.body              # Get the body of the incoming request.
    first_name = body['first_name']          # Get the 'first_name' value from the hash and save as variable. (json is passed into service as a string.)
    surname = body['surname']                # Get the 'last_name' value from the hash and save as variable.
    rendered = PresenterClass.render( body ) # Render body before validating.
    validation_error = PresenterClass.validate( rendered )
    if validation_error.has_errors?
      context.response.add_errors( validation_error )
    else
      context.response.set_resource( { 'message' => "Hello #{first_name} #{surname}" } ) # Set the resource of the response to message with the value of first_name then last_name
    end
  end
end

class ValidateInterface < Hoodoo::Services::Interface
  interface :Hello do                            # name of resource as a symbol.
    endpoint :Hello, ValidateImplementation      # Define the endpoint of the resource using uri fragment Hello followed by the implementation class name. URI defaults to path of .../v1/Hello
    public_actions :create                       # The 'public_actions' calls the create method found in the ValidateImplementation class.
  end
  # The to_create method is required for creating resource instances
  # From Hoodoo docs - If a call comes into the middleware from a client which contains body data that doesn't validate according to your schema, it'll be rejected before even getting as far as your interface implementation.
  to_create do
    resource PresenterClass
  end
end

# PresenterClass defines the JSON schema for the incoming request.
class PresenterClass < Hoodoo::Presenters::Base
  schema do
      text :first_name, :required => true
      text :surname,    :required => true
  end
end

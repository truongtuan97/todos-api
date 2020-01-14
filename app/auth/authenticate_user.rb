class AuthenticateUser
  def initialize(email, password)
    @email = email
    @password = password
  end

  # service entry point
  def call
    JsonWebToken.encode(user_id: user.id) if user
  end

  private 
  attr_reader :email, :password

  # verify user credential
  def user
    user = User.find_by(email: email)
    return user if user && user.authenticate(password)

    # raise Authenticate error if credentials are invalid
    raise(ExceptionHandler::AuthenticationError, Message.invalid_credentials)
  end
end
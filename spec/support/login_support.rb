module LoginSupport
  def log_in(user)
    post login_path, params: {
      session: { email: user.email, password: attributes_for(:user)[:password] }
    }
  end
end

RSpec.configure do |config|
  config.include LoginSupport
end

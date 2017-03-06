
Messiah::App.helpers do
  attr_writer :current_user

  def current_user
    return nil unless signed_in?
    @current_user ||= Account.find_by_id(session[:current_user])
    sign_out unless @current_user
    @current_user
  end

  def sign_in(user)
    session[:current_user] = user.id
    self.current_user = user
  end

  def sign_out
    session.delete(:current_user)
  end

  def signed_in?
    !session[:current_user].nil?
  end
end


Messiah::App.helpers do
  def signed_in?
    !current_account.nil?
  end
end

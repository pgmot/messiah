Messiah::App.controllers :auth do
  get '/twitter/callback' do
    auth    = request.env["omniauth.auth"]
    account = Account.find_by_provider_and_uid(auth["provider"], auth["uid"]) || Account.create_with_omniauth(auth)
    sign_in(account)

    TwitterRelationFetchWorker.perform_async(account.id)

    redirect "/"
  end
end

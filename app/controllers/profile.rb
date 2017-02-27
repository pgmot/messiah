Messiah::App.controllers :profile do
  get '/' do
    redirect '/profile/me'
  end

  get '/me' do
    if current_account
      @user = current_account
      render '/profile/index'
    else
      redirect '/'
    end
  end

  get '/logout' do
    set_current_account(nil)
    redirect '/'
  end

  get '/edit' do
    if current_account
      @user = current_account
      render '/profile/edit'
    else
      redirect '/'
    end
  end

  post '/edit' do
    account = current_account
    account.living_latitude = params[:latitude].to_f
    account.living_longitude = params[:longitude].to_f
    account.save
    redirect '/profile/me'
  end

  get '/:id' do
    @user = User.find_by_id(params[:id])
    if @user.nil?
        redirect '/'
    else
      render '/profile/index'
    end
  end
end

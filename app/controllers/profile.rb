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

  # get '/edit' do
  #   @user = current_user
  #   render '/profile/edit'
  # end
  #
  # post '/edit' do
  #   location = params[:location]
  #   @user = current_user
  #   geos = Geocoder.search(location)
  #   if geos.size == 1
  #     lat = geos[0].geometry['location']['lat']
  #     lng = geos[0].geometry['location']['lng']
  #     user = current_user
  #     user.living_latitude = lat
  #     user.living_longitude = lng
  #     user.save
  #     redirect '/profile/me'
  #   elsif geos.size > 1
  #     @locations = geos
  #     render '/profile/location_choose_one'
  #   else
  #     "Location Not Found :("
  #   end
  # end
  #
  # post '/edit/this_location' do
  #   user = current_user
  #   user.living_latitude = params[:lat]
  #   user.living_longitude = params[:lng]
  #   user.save
  #   redirect '/profile/me'
  # end

  # get '/:id' do
  #   @user = User.find_by_id(params[:id])
  #   if @user.nil?
  #       redirect '/'
  #   else
  #     render '/profile/index'
  #   end
  # end
end

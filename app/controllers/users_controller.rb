class UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_user, only: [:show, :edit, :update, :destroy, :finish_signup]

  def index
    user_id = current_user.id
  end

  def spotify
    spotify_user = RSpotify::User.new(request.env['omniauth.auth'])

    spotify_user.country
    spotify_user.email

    #Creating a playlist
    playlist = spotify_user.create_playlist!('')

    spotify_user.follow(playlist)

    tracks = RSpotify::Track.search('')
    playlist.add_tracks!(tracks)
  end

  def show
  end

  def friendship
  end



  def edit
  end

  def create
    @user = User.create(user_params)
  end

  def workout
  end

  def meal
  end

  def update
    respond_to do |format|
      if @user.update(user_params)
        sign_in(@user == current_user ? @user : current_user, :bypass => true)
        format.html { redirect_to @user, notice: 'Your profile was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  def finish_signup
    if request.patch? && params[:user]
      if @user.update(user_params)
        @user.skip_reconfirmation!
        sign_in(@user, :bypass => true)
        redirect_to @user, notice: 'Your profile was successfully updated.'
      else
        @show_errors = true
      end
    end
  end

  def destroy
    @user.destroy
    respond_to do |format|
      format.html {redirect_to root_url }
      format.json { head :no_content }
    end
  end

  private
    def set_user
      @user = User.find(params[:id])
    end

    def user_params
      params.require(:user).permit(:first_name, :last_name, :email, :avatar)
    end
end

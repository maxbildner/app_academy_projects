class UsersController < ApplicationController
  def index
      @users = User.all 
      render json: @users
  end

  def create
    # puts params[:favorite_food]             # params is a hash-like structure that we can do all kinds of cool things with
    # puts params[:favorite_animal]
    user = User.new(user_params)
        # .permit allows the name, and email attributes to be sent to the user (whitelisting of parameters)
        
    if user.save                              # trip to database (insert)
      render json: user
    else 
      render json: user.errors.full_messages, status: :unprocessable_entity
    end
  end

  def show
    @user = User.find(params[:id])
    render json: @user
  end

  def update                                    # will take in a body (find /users/2 to find User 2, then in body write new name and email)
    @user = User.find(params[:id])
    if @user.update(user_params)
      redirect_to '/users'
    else 
      render json: @user.errors.full_messages, status: :unprocessable_entity
    end
  end

  def destroy                                   # no body necessary, it's just gonna delete whoever is at that ID
    @user = User.find(params[:id])
    @user.destroy 
    redirect_to '/users' 
  end

  private                                       # refractor this so code is more DRY
  def user_params
    params.require(:user).permit(:username)
  end
end
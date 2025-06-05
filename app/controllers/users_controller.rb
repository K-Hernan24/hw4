class UsersController < ApplicationController
  def new
  end

  def create
    if User.find_by({"email" => params["email"]}) == nil
      @user = User.new
      @user["username"] = params["username"]
      @user["email"] = params["email"]
      @user["password"] = BCrypt::Password.create(params["password"])
      @user.save
      flash["notice"] = "Thanks for signing up. We are excited to know about your travel experiences."
      redirect_to "/login"
    else
      flash["notice"] = "Email already used"
      redirect_to "/users/new"
    end
  end
end

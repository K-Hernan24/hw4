class SessionsController < ApplicationController
  def new
    
  end

  def create
    @user = User.find_by({"email" => params["email"]})
    if @user != nil
      if BCrypt::Password.new(@user["password"]) == params["password"]
        session["user_id"] = @user["id"]
        redirect_to "/places"        
      else
        flash["notice"] = "Either username and/or password are incorrect. Please try again"
        redirect_to "/login"
      end
    else
      flash["notice"] = "Either username and/or password are incorrect. Please try again"
      redirect_to "/login"
    end
  end

  def destroy
    session["user_id"] = nil
    flash["notice"] = "Goodbye. We hope you had a wonderful experience in Travel Log. Cannot wait to hear your new adventures!"
    redirect_to "/login"
  end

end
  
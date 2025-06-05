class EntriesController < ApplicationController

  def index
    @entries = Entry.all

    respond_to do |format|
      format.html # implicitly renders posts/index.html.erb
      format.json do
        render :json => @entries.map { |entry|Add commentMore actions
          entry.as_json.merge(
            image: entry.uploaded_image.attached? ? url_for(entry.uploaded_image) : entry.image
          )
        }
      end
    end
  end
  
  def new
    @user = User.find_by({"id"=>session["user_id"]})
  end

  def create
    @user = User.find_by({"id"=>session["user_id"]})
    if @user != nil
      @entry = Entry.new
      @entry["title"] = params["title"]
      @entry["description"] = params["description"]
      @entry["occurred_on"] = params["occurred_on"]
      @entry["place_id"] = params["place_id"]
      @entry.uploaded_image.attach(params["uploaded_image"])
      @entry["user_id"] = @user["id"]
      @entry.save
      redirect_to "/places/#{@entry["place_id"]}"     
    else
      flash["notice"] = "Login required"
    end
  end

  # removes security restrictions for API calls
  before_action :allow_cors
  def allow_cors
    response.headers['Access-Control-Allow-Origin'] = '*'
    response.headers['Access-Control-Allow-Methods'] = 'POST, GET, PUT, PATCH, DELETE, OPTIONS'
    response.headers['Access-Control-Allow-Headers'] = 'Origin, Content-Type, Accept, Authorization, Token, Auth-Token, Email, X-User-Token, X-User-Email'
    response.headers['Access-Control-Max-Age'] = '1728000'
  end

end

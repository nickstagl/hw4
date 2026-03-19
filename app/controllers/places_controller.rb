class PlacesController < ApplicationController

  def index
    @places = Place.all
  end

  def show
    @place = Place.find_by({ "id" => params["id"] })
    @entries = Entry.where({ "place_id" => @place["id"], "user_id" => session["user_id"] })
  end

  def new
    @user = User.find_by({ "id" => session["user_id"] })
  end

  def create
    @user = User.find_by({ "id" => session["user_id"] })
    if @user != nil
      @place = Place.new
      @place["name"] = params["name"]
      @place.save
    else
      flash["notice"] = "You Must Login First"
    end

    redirect_to "/"
  end

end

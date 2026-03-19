class EntriesController < ApplicationController

  def new
    @place = Place.find_by({ "id" => params["place_id"] })
  end

  def create
    @user = User.find_by({ "id" => session["user_id"] })
    if @user != nil
      @entry = Entry.new
      @entry["title"] = params["title"]
      @entry["description"] = params["description"]
      @entry["occurred_on"] = params["occurred_on"]
      @entry["place_id"] = params["place_id"]
      @entry["user_id"] = session["user_id"]

      if params["image"].present?
        uploaded = params["image"]
        filename = "#{Time.now.to_i}_#{uploaded.original_filename}"
        File.open(Rails.root.join("public/uploads", filename), "wb") do |f|
          f.write(uploaded.read)
        end
        @entry["image"] = filename
      end

      @entry.save
    else
      flash["notice"] = "You Must Login First"
    end
    redirect_to "/places/#{params["place_id"]}"
  end

end

class ProfilesController < ApplicationController
  before_action :set_profile, only: [:show, :edit, :update, :destroy]
  # add authentication for all actions
  before_filter :authorize

  # GET /profiles
  # GET /profiles.json
  def index
    redirect_to articles_path, notice: 'Please provide valid URL'
    @profiles = Profile.all
  end

  # GET /profiles/1
  # GET /profiles/1.json
  def show
  end

  # GET /profiles/new
  def new
    @profile = Profile.new
  end

  # GET /profiles/1/edit
  def edit
  end

  # POST /profiles
  # POST /profiles.json
  def create
    @profile = Profile.new(profile_params)
    @profile.user_id = current_user.id
    @profile.first_name = params[:first_name]
    @profile.last_name = params[:last_name]

    respond_to do |format|
      if @profile.save
        current_user.update_attributes({first_name: params[:first_name], last_name: params[:last_name]})
        profile_picture = params[:profile][:profile_pic]
        if profile_picture.present?
          File.open(Rails.root.join('public', 'uploads', profile_picture.original_filename), 'wb') do |file|
            file.write(profile_picture.read)
          end
          @profile.update_attribute(:profile_pic, '/uploads/' + profile_picture.original_filename)
        end
        format.html { redirect_to @profile, notice: 'Profile was successfully created.' }
        format.json { render :show, status: :created, location: @profile }

      else
        format.html { render :new }
        format.json { render json: @profile.errors, status: :unprocessable_entity }

      end
    end
  end

  # PATCH/PUT /profiles/1
  # PATCH/PUT /profiles/1.json
  def update
    respond_to do |format|
      @profile.first_name = params[:first_name]
      @profile.last_name = params[:last_name]

      if @profile.update(profile_params)
        current_user.update_attributes({first_name: params[:first_name], last_name: params[:last_name]})
        profile_picture = params[:profile][:profile_pic]
        if profile_picture.present?
          File.open(Rails.root.join('public', 'uploads', profile_picture.original_filename), 'wb') do |file|
            file.write(profile_picture.read)
          end
          @profile.update_attribute(:profile_pic, '/uploads/' + profile_picture.original_filename)
        end
        format.html { redirect_to @profile, notice: 'Profile was successfully updated.' }
        format.json { render :show, status: :ok, location: @profile }
      else
        format.html { render :edit }
        format.json { render json: @profile.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /profiles/1
  # DELETE /profiles/1.json
  def destroy
    @profile.destroy
    respond_to do |format|
      format.html { redirect_to profiles_url, notice: 'Profile was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_profile
      @profile = Profile.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def profile_params
      params.require(:profile).permit(:user_id, :home_address, :description, :profile_pic)
    end
end

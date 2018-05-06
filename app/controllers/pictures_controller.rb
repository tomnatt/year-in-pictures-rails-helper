require 'date_service'

class PicturesController < ApplicationController
  before_action :set_picture, only: [:show, :edit, :update, :destroy]
  before_action :check_user_authorised, only: [:show, :edit, :update, :destroy]
  before_action :set_users, only: [:new, :edit, :create, :update]

  # GET /pictures
  # GET /pictures.json
  def index
    last_month = DateService.define_last_month
    @last_month_name = Date::MONTHNAMES[last_month]
    @last_month_pictures = Picture.where(month: last_month)
    @pictures = set_picture_list

    # Construct a hash of { photographer => photo_submitted? }
    @photographers = {}
    User.all.each do |user|
      @photographers[user.fullname] = @last_month_pictures.any? { |pic| pic.user == user }
    end
  end

  # GET /pictures/1
  # GET /pictures/1.json
  def show; end

  # GET /pictures/new
  def new
    @picture = Picture.new
    @picture.user = current_user
  end

  # GET /pictures/1/edit
  def edit; end

  # POST /pictures
  # POST /pictures.json
  def create
    redirect_to root_url and return unless check_ownership(picture_params[:user_id])
    @picture = Picture.new(picture_params)
    respond_to do |format|
      if @picture.save
        format.html { redirect_to @picture, notice: 'Picture was successfully created.' }
        format.json { render :show, status: :created, location: @picture }
      else
        format.html { render :new }
        format.json { render json: @picture.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /pictures/1
  # PATCH/PUT /pictures/1.json
  def update
    redirect_to root_url and return unless check_ownership(picture_params[:user_id])
    respond_to do |format|
      if @picture.update(picture_params)
        format.html { redirect_to @picture, notice: 'Picture was successfully updated.' }
        format.json { render :show, status: :ok, location: @picture }
      else
        format.html { render :edit }
        format.json { render json: @picture.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /pictures/1
  # DELETE /pictures/1.json
  def destroy
    @picture.destroy
    respond_to do |format|
      format.html { redirect_to pictures_url, notice: 'Picture was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_picture
    @picture = Picture.find(params[:id])
  end

  def check_user_authorised
    return if @picture.user == current_user || current_user.admin?
    redirect_to root_url
  end

  def check_ownership(id)
    return true if id.to_i == current_user.id.to_i || current_user.admin?
    false
  end

  def set_users
    @users = User.all.order(:fullname)
  end

  def set_picture_list
    current_user.admin? ? Picture.sort_by_date_user : Picture.sorted_filtered_for_user(current_user)
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def picture_params
    params.require(:picture).permit(:user_id,
                                    :image_title,
                                    :caption,
                                    :description,
                                    :month,
                                    :year,
                                    :image,
                                    :alt)
  end
end

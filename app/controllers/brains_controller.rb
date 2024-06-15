class BrainsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  before_action :set_brain, only: [:show, :edit, :update, :destroy]

  def index
    @brains = Brain.all
    if user_signed_in?
      @my_brain = current_user.owned_brain
      @booking = @my_brain&.bookings&.find_by(status: 'active') if @my_brain
    end
    @available_brains = Brain.where(available: true)

    @markers = @brains.geocoded.map do |brain|
      {
        lat: brain.latitude,
        lng: brain.longitude,
        info_window_html: render_to_string(partial: "info_window", locals: {brain: brain}),
        marker_html: render_to_string(partial: "marker")
      }
    end
  end

  def show
    @bookings = @brain.bookings.all
  end

  def new
    if current_user.owned_brain
      redirect_to current_user.owned_brain, alert: 'You can only create one brain.'
    else
      @brain = Brain.new
    end
  end

  def create
    @brain = Brain.new(brain_params)
    @brain.user = current_user

    if @brain.save
      redirect_to @brain, notice: 'Brain was successfully created.'
    else
      render :new
    end
  end

  def edit
    unless @brain.user == current_user
      redirect_to @brain, alert: "You are not authorized to edit this brain."
    end
  end

  def update
    if @brain.update(brain_params)
      redirect_to @brain, notice: 'Brain was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    if @brain.user == current_user
      @brain.destroy
      redirect_to brains_url, notice: 'Brain was successfully destroyed.'
    else
      redirect_to @brain, alert: "You are not authorized to delete this brain."
    end
  end

  private

  def set_brain
    @brain = Brain.find(params[:id])
  end

  def brain_params
    params.require(:brain).permit(:name, :characteristics, :description, :specialities, :location, :available, :photo)
  end
end

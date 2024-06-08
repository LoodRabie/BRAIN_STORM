class BookingsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_booking, only: [:show, :destroy, :edit, :update]

  def index
    @bookings = current_user.bookings.where(status: 'active')
  end

  def new
    @booking = Booking.new
    @brain = Brain.find(params[:brain_id])
  end

  def create
    @brain = Brain.find(params[:brain_id])

    if @brain.user_id == current_user.id
      redirect_to @brain, alert: "You cannot book your own brain."
      return
    end

    @booking = Booking.new(booking_params)
    @booking.user = current_user
    @booking.brain = @brain
    @booking.status = "Pending"

    if booking_conflict?
      render :new, notice: "You are not authorized to delete this brain."
    elsif @booking.save
      redirect_to booking_path(@booking), notice: 'Booking was successfully created.'
    else
      render :new
    end
  end

  def show
  end

  def my_bookings
    @bookings = current_user.bookings
  end

  def destroy
    @booking.destroy
    redirect_to my_bookings_path, notice: 'Booking was successfully destroyed.'
  end

  def edit
    @brain = @booking.brain
  end

  def update
    if @booking.update(booking_params)
      redirect_to brains_path(@brain), notice: 'Booking status updated successfully.'
    else
      render :edit
    end
  end

  private

  def set_booking
    @booking = Booking.find(params[:id])
  end

  def booking_params
    params.require(:booking).permit(:brain_id, :start_date, :length_of_time, :status)
  end

  def booking_conflict?
    existing_bookings = @brain.bookings.where("start_date <= ? AND (start_date + interval '1 day' * length_of_time) > ?", @booking.start_date, @booking.start_date)
    existing_bookings.exists?
  end
end

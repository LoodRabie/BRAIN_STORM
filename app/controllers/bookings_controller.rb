class BookingsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_booking, only: [:show, :destroy]

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

    if @booking.save
      redirect_to @booking, notice: 'Booking was successfully created.'
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
    redirect_to bookings_url, notice: 'Booking was successfully destroyed.'
  end

  private

  def set_booking
    @booking = Booking.find(params[:id])
  end

  def booking_params
    params.require(:booking).permit(:brain_id, :start_date, :end_date)
  end
end

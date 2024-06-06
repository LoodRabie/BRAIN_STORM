class BookingsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_brain
  before_action :set_booking, only: [:show, :destroy]

  def index
    @bookings = @brain.bookings
  end

  def show
  end

  def my_bookings
    @my_bookings = current_user.brain.bookings
  end

  def new
    @booking = @brain.bookings.new
  end

  def create
    @booking = @brain.bookings.new(booking_params)
    @booking.user = current_user

    if @booking.save
      redirect_to brain_booking_path(@brain, @booking), notice: 'Booking was successfully created.'
    else
      render :new
    end
  end

  def destroy
    @booking.destroy
    redirect_to brain_bookings_path(@brain), notice: 'Booking was successfully destroyed.'
  end

  private

  def set_brain
    @brain = Brain.find(params[:brain_id])
  end

  def set_booking
    @booking = @brain.bookings.find(params[:id])
  end

  def booking_params
    params.require(:booking).permit(:length_of_time, :start_date, :status)
  end
end

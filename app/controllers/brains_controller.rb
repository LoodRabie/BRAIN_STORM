class BrainsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  before_action :set_brain, only: [:show, :edit, :update, :destroy]

  def index
    @brains = Brain.all
    @brain = Brain.new
  end

  def show
  end

  def new
    @brain = Brain.new
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
    params.require(:brain).permit(:name, :characteristics, :description, :specialities, :available)
  end
end

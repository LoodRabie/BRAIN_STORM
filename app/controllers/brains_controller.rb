class BrainsController < ApplicationController
  def index
    @brains = Brain.all
  end

  def new
    @brains = Brain.new
  end

  def create
    @brain = Brain.new(brain_params)
    @brain.save
    redirect_to brain_path(@brain)
  end
end

private

def brain_params
  params.require(:brain).permit(:name, :characteristics, :description, :specialities, :available)
end

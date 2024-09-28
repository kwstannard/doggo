class DogsController < ApplicationController
  def index
    @dogs = Dog.all
  end

  def new
    @dog = Dog.new
  end

  def edit
    @dog = Dog.find(params[:id])
  end

  def update
    dog = Dog.find(params[:id])
    if dog.update(dog_params)
      redirect_to dogs_path
    else
      flash[:error] = dog.errors.full_messages

      render :new
    end
  end

  def create
    dog = Dog.new(dog_params)
    if dog.save
      redirect_to dogs_path
    else
      flash[:error] = dog.errors.full_messages

      render :new
    end
  end

  def dog_params
    params.fetch(:dog, {}).permit(
      :name,
      :Monday,
      :Tuesday,
      :Wednesday,
      :Thursday,
      :Friday,
    )
  end
end

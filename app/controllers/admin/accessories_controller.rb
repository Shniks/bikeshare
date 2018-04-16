class Admin::AccessoriesController < Admin::BaseController
  def index
    @accessories = Accessory.all
  end

  def new
    @accessory = Accessory.new
  end

  def create
    @accessory = Accessory.new(accessory_params)
    @accessory[:price] = normalize_price
    if @accessory.save
      flash[:success] = "#{@accessory.title} Added!"
      redirect_to accessory_path(@accessory)
    else
      flash[:error] = "Accessory not added."
      redirect_to accessories_path
    end
  end

  def edit
    @accessory = Accessory.find(params[:id])
  end

  def update
    @accessory = Accessory.find(params[:id])
    if @accessory.update(accessory_params)
      flash[:success] = "#{@accessory.title} updated."
      redirect_to accessory_path(@accessory)
    else
      flash[:error] = 'Something went wrong.'
      render :edit
    end
  end

  private

  def normalize_price
    if accessory_params[:price].to_i < 0
      return accessory_params[:price] = 0
    else
      accessory_params[:price]
    end
  end

  def accessory_params
    params.require(:accessory).permit(:title, :description, :price, :image_file_name, :role)
  end

end

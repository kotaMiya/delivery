class DriversController < ApplicationController
  def index
    @driver = Driver.find(params[:id])
    @packages = Package.all.include(@driver.id)
  end
  
  def new
    @driver = Driver.new
  end
  
  def show
    @driver = Driver.find(params[:id])
    @packages = Package.all
  end
  
  def create
    @driver = Driver.new(driver_params)
    if @driver.save
      log_in @driver
      redirect_to @driver
    else
      render 'new'
    end
  end
  
  private

    def driver_params
      params.require(:driver).permit(:name, :email, :password,
                                   :password_confirmation)
    end
end

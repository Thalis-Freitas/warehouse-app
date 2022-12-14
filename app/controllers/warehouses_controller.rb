class WarehousesController < ApplicationController
  before_action :set_warehouse, only:[:show, :edit, :update, :destroy]

  def show
    formatted_zip_code @warehouse
    @warehouse[:code].upcase!
    @stocks = @warehouse.stock_products.where.missing(:stock_product_destination).group(:product_model).count
    @product_models = @warehouse.set_product_models
  end
  
  def new
    @warehouse = Warehouse.new
  end

  def create
    @warehouse = Warehouse.new(warehouse_params)
    if @warehouse.save
      redirect_to root_url, notice: 'Galpão cadastrado com sucesso'
    else
      flash.now[:notice] = 'Galpão não cadastrado'
      render :new
    end
  end

  def edit; end

  def update 
    if @warehouse[:name] == warehouse_params[:name] && @warehouse[:description] == warehouse_params[:description] && @warehouse[:code] == warehouse_params[:code] && @warehouse[:city] == warehouse_params[:city] && @warehouse[:address] == warehouse_params[:address] && @warehouse[:zip_code] == warehouse_params[:zip_code] && "#{@warehouse[:area]}" == "#{warehouse_params[:area]}"
      flash.now[:alert] = 'Nenhuma modificação encontrada'
      render :edit
    else
      if @warehouse.update(warehouse_params) 
        redirect_to @warehouse, notice: 'Galpão atualizado com sucesso'
      else
        flash.now[:alert] = 'Não foi possível atualizar o galpão'
        render :edit
      end
    end
  end

  def destroy 
    @warehouse.destroy  
    redirect_to root_url, notice: 'Galpão removido com sucesso'
  end

  private
  
  def set_warehouse
    @warehouse = Warehouse.find(params[:id])
  end

  def warehouse_params
    params.require(:warehouse).permit(:name, :code, :city, :description, :address,
                                      :zip_code, :area)
  end

  def formatted_zip_code(warehouse)
    warehouse[:zip_code].insert(5, '-') if warehouse[:zip_code].length == 8 
  end 
end
class OrdersController < ApplicationController
  before_action :set_order_and_check_user, only:[:show, :edit, :update, :delivered, :canceled]
  before_action :order_params, only:[:create, :update]

  def index 
    @orders = current_user.orders
  end
  
  def new
    @order = Order.new
    @warehouses = Warehouse.order(:name)
    @suppliers = Supplier.order(:corporate_name)
  end

  def create
    @order = Order.new(order_params)
    @order.user = current_user 
    if @order.save 
      redirect_to @order, notice: 'Pedido registrado com sucesso'
    else
      @warehouses = Warehouse.order(:name)
      @suppliers = Supplier.order(:corporate_name)
      flash.now[:alert] = 'Não foi possível cadastrar o pedido'
      render :new
    end
  end

  def show; end

  def search
    @code = params[:query]
    if @code.strip != ""
      @orders = Order.where("code LIKE ?", "%#{@code}%")
    end
  end

  def edit
    @warehouses = Warehouse.order(:name)
    @suppliers = Supplier.order(:corporate_name)
  end

  def update
    @order.update(order_params)
    redirect_to @order, notice: 'Pedido atualizado com sucesso'
  end

  def delivered
    @order.delivered!
    @order.create_stock_when_delivered
    redirect_to @order
  end

  def canceled
    @order.canceled!
    redirect_to @order
  end

  private

  def set_order_and_check_user
    @order = Order.find(params[:id])
    if @order.user != current_user
      return redirect_to root_path, alert: 'Você não possui acesso a este pedido'
    end
  end

  def order_params
    params.require(:order).permit(:warehouse_id, :supplier_id, :estimated_delivery_date)
  end
end
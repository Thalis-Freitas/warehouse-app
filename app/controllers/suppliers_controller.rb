class SuppliersController < ApplicationController
  before_action :set_supplier, only:[:show]

  def index
    @suppliers = Supplier.all
  end

  def show
    formatted_document @supplier
  end

  def new
    @supplier = Supplier.new
  end

  def create
    @supplier = Supplier.new(supplier_params)
    if @supplier.save
      redirect_to @supplier, notice: 'Fornecedor cadastrado com sucesso'
    else
      flash.now[:alert] = 'Fornecedor não cadastrado'
      render :new
    end  
  end

  private

  def set_supplier
    @supplier = Supplier.find(params[:id])
  end

  def formatted_document(supplier)
    document = supplier[:registration_number]
    document.insert(2, '.')
    document.insert(6, '.')
    document.insert(10, '/')
    document.insert(15, '-')
  end

  def supplier_params
    params.require(:supplier).permit(:corporate_name, :brand_name, :registration_number, :full_address, :city,
                                     :state, :email)
  end
end
class SuppliersController < ApplicationController
  before_action :set_supplier, only:[:show, :edit, :update]

  def index
    @suppliers = Supplier.all
  end

  def show
    formatted_document @supplier
    @supplier[:state].upcase!
    @product_models = ProductModel.all.select do |m|
      m if m.supplier_id.eql? @supplier.id
    end
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

  def edit; end

  def update
    if @supplier[:corporate_name] == supplier_params[:corporate_name] && @supplier[:brand_name] == supplier_params[:brand_name] && @supplier[:registration_number] == supplier_params[:registration_number] && @supplier[:full_address] == supplier_params[:full_address] && @supplier[:city] == supplier_params[:city] && @supplier[:state] == supplier_params[:state] && @supplier[:email] == supplier_params[:email]
      flash.now[:alert] = 'Nenhuma modificação encontrada'
      render :edit
    else
      if @supplier.update(supplier_params) 
        redirect_to @supplier, notice: 'Fornecedor atualizado com sucesso'
      else
        flash.now[:alert] = 'Não foi possível atualizar o fornecedor'
        render :edit
      end
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
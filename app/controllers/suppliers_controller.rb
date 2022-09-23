class SuppliersController < ApplicationController
  before_action :set_supplier, only:[:show]

  def index
    @suppliers = Supplier.all
  end

  def show
    formatted_document @supplier
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
end
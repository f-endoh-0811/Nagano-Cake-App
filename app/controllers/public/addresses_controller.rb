class Public::AddressesController < ApplicationController
  before_action :authenticate_customer!

  def index
    @addresses = current_customer.addresses.all
    @address = Address.new
  end

  def edit
    @address = current_customer.addresses.find(params[:id])
  end

  def create
    address = Address.new(address_params)
    address.customer_id = current_customer.id
    address.save
    redirect_to addresses_path
  end

  def update
    address = current_customer.addresses.find(params[:id])
    address.update(address_params)
    redirect_to addresses_path
  end

  def destroy
    address = current_customer.addresses.find(params[:id])
    address.destroy
    redirect_to addresses_path
  end

  private

  def address_params
    params.require(:address).permit(:postal_code, :address, :name)
  end
end

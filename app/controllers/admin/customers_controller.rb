class Admin::CustomersController < ApplicationController
    # 管理者でログインしているのみ閲覧可にするメソッド
  before_action :authenticate_admin!
  
  def show
    @customer = Customer.find(params[:id])
    @items = @customer.items
  end
  def index
    @customers = Customer.page(params[:page])
  end

  def show
    @customer = Customer.find(params[:id])
  end

  def edit
    @customer = Customer.find(params[:id])
  end

  def update
    @customer = Customer.find(params[:id])
    if @customer.update(customer_params)
      redirect_to admin_customer_path(@customer.id)
    else
      render :edit
    end
  end
  
  def search
    @customers = Customer.search(params[:keyword])
    @keyword = params[:keyword]
    render "index"
  end

  private

  def customer_params
    params.require(:customer).permit(:name, :email, :is_deleted)
  end

end

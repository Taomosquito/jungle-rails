class Admin::DashboardController < ApplicationController
  def show
    @countProducts = Product.count(:id)
    @countCategories = Category.count(:id)
  end
end

class CategoriesController < ApplicationController

  def index
    if params[:item_id]
      @item = Item.find_by(id: params[:item_id])
      if @item.nil?
        redirect_to item_path, alert: "That item does not exist"
      else
        
  end
end

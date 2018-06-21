class CategoriesController < ApplicationController

  def index
  end

  def new
    if params[:item_id] && !Item.exists?(params[:item_id])
      redirect_to item_path, alert: "Item not found"
    else
      @item = Item.find(params[:item_id])
      @category = item.categories.build
    end
  end
  
  def create
    if params[:item_id] && !Item.exists?(params[:item_id])
      redirect_to item_path, alert: "Item not found"
    else
      @item = Item.find(params[:item_id])
      if @category = item.categories.create(category_params)
        redirect_to item_category_path(@item, @category)
      else
        render :new
      end
    end
  end

  def update
    @category = Category.find(params[:id])
    @category.update

    if @category.save
      redirect_to category_path(@category)
    else
      render :edit
    end
  end

  def destroy
    Category.find(params[:id]).destroy
    redirect_to :root
  end

  def show
    if params[:item_id]
      @item = Item.find_by(id: params[:item_id])
      @category = @item.categories.find_by(id: params[:id])
      #for JSON
      @logs = @category.logs
      if @category.nil?
        #should this be item_path?
        redirect_to item_category_path(@item), alert: "Category not found"
      end
    else
      @category = Category.find(params[:id])
    end

    respond_to do |format|
      format.html { render :show}
      format.json { render json: @logs}
    end

  end

  def edit
    if params[:item_id]
      item = Item.find_by(id: params[:item_id])
      if item.nil?
        redirect_to item_path, alert: "item not found"
      else
        @category = item.categories.find_by(id: params[:id])
        redirect_to item_categories_path, alert: "category not found"
      end 
    else
      @category = Category.find(params[:id])
    end
  end

  private

  def category_params
    params.require(:category).permit(:name, :item_id)
  end

end

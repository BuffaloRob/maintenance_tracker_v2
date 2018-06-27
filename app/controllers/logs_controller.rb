class LogsController < ApplicationController

  def index
    if params[:category_id]
      @category = Category.find_by(id: params[:category_id])
      if @category.nil?
        redirect_to category_path, alert: "That category doesn't exist"
      else
        @logs = @category.logs
      end
    else
      @logs = Log.all
    end
  end

  def new
    if params[:item_id] && !Item.exists?(params[:item_id])
      redirect_to :root, alert: "That item doesn't exist"
    else
      @item = Item.find(params[:item_id])
      @log = @item.logs.build
    end
  end

  def create
    if params[:item_id] && !Item.exists?(params[:item_id])
      redirect_to item_path, alert: "That item doesn't exist"
    else
      @item = Item.find(params[:item_id])
      @log = @item.logs.create(log_params)
      if @log.valid?
        respond_to do |format|
          format.html { redirect_to item_log_path(@item, @log) }
          format.json { render json: @log }
        end
      else
        render :new
      end
    end
  end

  def show
    if params[:category_id]
      @category = Category.find_by(id: params[:category_id])
      @log = @category.logs.find_by(id: params[:id])
      if @log.nil?
        redirect_to category_log_path(@category), alert: "Log not found"
      end
    else
      @log = Log.find(params[:id])
    end

    respond_to do |format|
      format.html { render :show }
      format.json { render json: @log }
    end
  end

  def update
    @log = Log.find(params[:id])
    @log.update(log_params)
    if @log.save
      redirect_to log_path(@log)
    else
      render :edit
    end
  end

  def edit
    if params[:category_id]
      category = Category.find_by(id: params[:category_id])
      if category.nil?
        redirect_to category_path, alert: "Category not found"
      else
        @log = category.logs.find_by(id: params[:id])
        redirect_to category_logs_path, alert: "Log not found"
      end
    else
      @log = Log.find(params[:id])
    end
  end

  def destroy
    Log.find(params[:id]).destroy
    redirect_to :root
  end

  def past_due
    @current_user_logs = []
    @items = current_user.items
    @items.each do |item|
      item.logs.past_due.each do |log|
        @current_user_logs << log
      end
    end
  end

  def upcoming
    @current_user_logs = []
    @items = current_user.items
    @items.each do |item|
      item.logs.upcoming.each do |log|
        @current_user_logs << log
      end
    end
  end

  

  private

  def log_params
    params.require(:log).permit(:notes, :tools, :cost, :date_performed, :date_due, :category_id, :item_id, category_attributes: [:name, :id])
  end

end

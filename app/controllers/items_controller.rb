class ItemsController < ApplicationController
  before_action :set_item, only: [:show, :edit, :update, :destroy]

	def index
		if current_user
			@items = current_user.items
		else
			redirect_to new_user_session_path
		end
	end

	def new
		@item = Item.new
	end

	def create
		@item = current_user.items.build(item_params)
		if @item.save
			redirect_to item_path(@item)
		else
			render :new
		end
	end

	def update
		@item.update(item_params)
		redirect_to item_path(@item)
	end

	def destroy 
		@item.destroy
		redirect_to items_path
	end

	def show
		#for use with form to make a new log
		@log = @item.logs.build
	end

	def edit
	end

	private

	def set_item 
		@item = Item.find(params[:id])
	end

	def item_params
		params.require(:item).permit(:name, :user_id)
	end


end

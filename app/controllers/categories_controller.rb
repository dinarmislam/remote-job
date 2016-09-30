class CategoriesController < ApplicationController
  def index
    @categories = Category.all
  end
  def show
    @category = Category.find(params[:id])
  end
  def jobs
    @categories = Category.all
    respond_to do |format|
      format.rss { render :layout => false }
    end
  end
  private
    def category_params
      params.require(:category).permit(:name)
    end
end

class CategoriesController < ApplicationController
  before_action :set_category, only: [:show, :edit, :update]
  def index
    @categories = Category.all
  end

  def show
  end

  def new
    @category = Category.new
  end

  def create
    @category = Category.new(category_params)
    if @category.save
      flash[:success]="Category created"
      redirect_to root_url
    else
      flash[:notice]="Category not created"
      render 'new'
    end
  end

  def edit

  end

  def update
    if @category.update(category_params)
      flash[:success]="Category updated"
      redirect_to root_url
    else
      flash[:notice]="Category not updated"
      render 'new'
    end
  end

  private

    def category_params
      params.require(:category).permit(:name)
    end

    def set_category
      @category = Category.find_by(slug: params[:id])
    end
end
class CategoriesController < ApplicationController
  respond_to :html
  before_action :authenticate_user!, except: [:index, :show]
  before_action :authorize_admin!, except: [:index, :show]
  before_action :find_category, only: [:show, :edit, :update, :destroy]

  def index
    @posts = Post.published
    find_category_firsts
  end

  def show
    @posts = @category.posts.published.page(params[:page]).per_page(9)
    @latest = @posts.first
  end

  def new
    @category = Category.new
  end

  def edit
  end

  def create
    @category = Category.new(params[:category])

    if @category.save
      flash[:notice] = 'Category was successfully created.'
      redirect_to(@category)
    else
      render action: 'new'
    end
  end

  def update
    if @category.update_attributes(params[:category])
      flash[:notice] = 'Category was successfully updated.'
      redirect_to(@category)
    else
      render action: 'edit'
    end
  end

  def destroy
    redirect_to(categories_url) if @category.destroy
  end

  private

  def find_category
    @category = Category.friendly.find(params[:id])
  end

  def find_category_firsts
    @cover = get_first_post_from('featured')
    @quicktrip = get_first_post_from('quicktrips')
    @food = get_first_post_from('food')
    @drink = get_first_post_from('drinks')
    @garage = get_first_post_from('garage')
  end

  def get_first_post_from(category)
    Category.friendly.find(category).posts.published.first
  end
end

# Blog post actions, split into public and admin actions.
class PostsController < ApplicationController
  respond_to :html, :json
  before_action :authorize_admin!, except: [:index, :show, :feed]
  before_action :find_post, only: [:show, :edit, :update, :destroy]

  # PUBLIC ACTIONS
  def index
    @posts = Post.published.page(params[:page]).per_page(19)
    @first = Post.published.first
    respond_with(@posts)
  end

  def show
    @post = Post.includes(:assets, :categories, experiences: [:state, :user])
      .published.friendly.find(params[:id])
  end

  def feed
    @title = 'The Democratic Travelers'
    @posts = Post.includes(:user).published.order('published_at desc')
    @updated = @posts.first.updated_at unless @posts.empty?

    respond_to do |format|
      format.atom { render layout: false }
      format.rss do
        redirect_to feed_path(format: :atom), status: :moved_permanently
      end
    end
  end

  # ADMIN ACTIONS
  def new
    @post = Post.new
    find_experiences
  end

  def edit
    find_experiences
  end

  def create
    @post = Post.new(post_params)

    if @post.save
      notify_contributors(@post) if params[:notify_contributors]
      flash[:notice] = 'You are incredibly productive.
                        New blog post has been created!'
      redirect_to @post
    else
      render action: 'new'
    end
  end

  def update
    if @post.update_attributes(post_params)
      notify_contributors(@post) if params[:notify_contributors]
      flash[:notice] = 'Totally updated that bitch of a post.'
      redirect_to @post
    else
      render action: 'edit'
    end
  end

  def destroy
    redirect_to(blog_url) if @post.destroy
  end

  private

  def post_params
    params.require(:post).permit(
      :title, :subtitle, :excerpt, :body, :slug, :user_id, :published_at,
      category_ids: [], asset_ids: [], experience_ids: []
    )
  end

  def find_post
    @post = Post.friendly.find(params[:id])
  end

  def find_experiences
    @experiences = Experience.done
  end

  def notify_contributors(post)
    if post.experiences.any?
      post.experiences.each do |e|
        ExperienceMailer.delay.we_blogged_this(e.id) if e.user.email.present?
      end
    end
  end
end

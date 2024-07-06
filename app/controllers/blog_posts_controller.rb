class BlogPostsController < ApplicationController
  # before_action(:set_blog_post, only: %i[show edit update destroy])
  before_action(:authenticate_user!, except: %i[index show])
  before_action(:set_blog_post, except: %i[index new create])
  # Index action to render all blog posts
  # Define an instance variable to hold all blog posts
  # Instance variables can be accessed in the view
  def index
    @blog_posts = user_signed_in? ? BlogPost.sorted : BlogPost.published.sorted
  end

  def show; end

  def new
    @blog_post = BlogPost.new
  end

  def create
    # Create a new blog post with the permitted params
    @blog_post = BlogPost.new(blog_post_params)

    # If blog post is saved, redirect to blog post (show template)
    # save returns false if the record is invalid
    if @blog_post.save
      redirect_to @blog_post
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    puts @blog_post.inspect
    redirect_to root_path if @blog_post.nil?
  end

  def update
    # If number of rows updated is greater than 0, redirect to blog post
    if @blog_post.update(blog_post_params)
      redirect_to @blog_post
    else
      # If number of rows updated is 0, render edit template
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @blog_post.destroy
    redirect_to root_path
  end

  private

  # Define private method to permit require :blog_post key in params object
  # Then permit and extract only :title and :body keys
  def blog_post_params
    params.require(:blog_post).permit(:title, :body, :published_at)
  end

  def set_blog_post
    @blog_post = user_signed_in? ? BlogPost.find(params[:id]) : BlogPost.published.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    redirect_to root_path
  end
end

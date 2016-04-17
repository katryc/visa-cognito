class PostsController < ApplicationController

  before_action :find_post, except: [:index, :new, :create]

  def index
    @array = []
    posts = Post.all.shuffle
    # @posts = Post.all

  end

  def show
  end

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)

    if @post.save
      recognize

    else
      render :new
    end
  end

  def edit
  end

  def update
    if @post.update(post_params)
      redirect_to posts_path
    else
      render :edit
    end
  end

  def destroy
    @post.destroy
    redirect_to posts_path
  end

  def enroll
    url = @post.image.url
    Post.enroll(url)
    render :show
  end

  def recognize
    url = @post.image.url
    successtest = Post.recognize(url)
    if successtest == "success"
      render :great_success
    else
      render :great_fail
    end
  end

  def ctc_post(wait_time)
    Post.ctc_post_off()
    wait_time = wait_time * 60
    sleep(wait_time)
    Post.ctc_post_on()
  end


  private

  def post_params
    params.require(:post).permit(:title, :image)
  end

  def find_post
    @post = Post.find(params[:id])
  end

end

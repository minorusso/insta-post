class BlogsController < ApplicationController
  before_action :set_blog, only: %i[show edit update destroy]
  before_action :prohibit_access, only: %i[edit update destroy]

  # GET /blogs or /blogs.json
  def index
    @blogs = Blog.all
  end

  # GET /blogs/1 or /blogs/1.json
  def show
    @favorite = current_user.favorites.find_by(blog_id: @blog.id)
  end

  # GET /blogs/new
  def new
    @blog = Blog.new
  end

  # GET /blogs/1/edit
  def edit; end

  # POST /blogs or /blogs.json
  def create
    @blog = current_user.blogs.build(blog_params)
    if params[:back]
      render :new
    elsif @blog.save
      ConfirmMailer.confirm_mail(@blog).deliver
      redirect_to blogs_path, notice: '確認メールを送信しました。'
    else
      render :new
    end
  end

  def confirm
    @blog = current_user.blogs.build(blog_params)
    render :new if @blog.invalid?
  end

  # PATCH/PUT /blogs/1 or /blogs/1.json
  def update
    respond_to do |format|
      if @blog.update(blog_params)
        format.html { redirect_to @blog, notice: 'Blog was successfully updated.' }
        format.json { render :show, status: :ok, location: @blog }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @blog.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /blogs/1 or /blogs/1.json
  def destroy
    @blog.destroy
    respond_to do |format|
      format.html { redirect_to blogs_url, notice: 'Blog was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_blog
    @blog = Blog.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def blog_params
    params.require(:blog).permit(:title, :content, :user_id, :img, :img_cache)
  end
  
  def prohibit_access
    redirect_to blogs_path unless current_user.id == @blog.user.id
    flash[:notice] = "権限がありません"
  end
end

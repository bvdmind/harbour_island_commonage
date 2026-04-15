class PostsController < ApplicationController
    before_action :set_post, only: %i[show edit update destroy]
    before_action :require_admin!, only: %i[new create edit update destroy]

    def index
        @posts = Post.includes(:user).order(created_at: :desc)
    end

    def show
    end

    def new
        @post = Post.new
    end

    def create
        @post = Current.user.posts.build(post_params)
        if @post.save
            redirect_to @post, notice: "post created."
        else
            render :new, status: :unprocessable_entity
        end
    end

    def edit
    end

    def update
        if params[:post][:remove_image] == "1"
            @post.image.purge
        end

        if @post.update(post_params)
            redirect_to @post, notice: "Post updated."
        else
            render :edit, status: :unprocessable_entity
        end
    end

    def destroy
        @post.destroy
        redirect_to posts_path, notice: "post deleted."
    end

    private

    def set_post
        @post = Post.find(params[:id])
    end

    def post_params
        params.require(:post).permit(:title, :body, :image)
    end

    def require_admin!
    redirect_to root_path, alert: "Not authorized" unless Current.user&.admin?
    end
end

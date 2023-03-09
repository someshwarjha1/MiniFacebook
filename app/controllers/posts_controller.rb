class PostsController < ApplicationController

    def show
        @post = Post.find(params[:id])
    end

    def index
        @posts = current_user.posts 
    end
    def new
        @post = Post.new
    end
    def create
        post = Post.new(set_params)
        post.user_id = current_user.id
        if post.save 
            redirect_to root_path
        else 
            puts post.errors.full_messages
            render 'new'

        end
    end 

    def view
        lst_of_ids = current_user.all_friends.pluck(:id)
        @posts = Post.where(user_id:lst_of_ids).order(created_at: :desc)

    end

    def create_like
        @post = Post.find(params[:id])
        current_user.likes.create(post: @post)
        @post.update(likes_count: @post.likes.count)
        redirect_to @post
    end

    def destroy_like
        @like = current_user.likes.find_by(post_id: params[:id])
        @like.destroy
        @post = Post.find(params[:id])
        @post.update(likes_count: @post.likes.count)
        redirect_to @post
    end

    def create_comment
        @post = Post.find(params[:id])
        @comment = @post.comments.create(comment_params.merge(user: current_user))
        redirect_to @post
    end

    private

    def set_params
        params.require(:post).permit(:caption, :image)
    end

    def comment_params
        params.permit(:body)
    end

end

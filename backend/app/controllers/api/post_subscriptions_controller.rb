class Api::PostSubscriptionsController < ApplicationController
    before_action :authenticate_user!

    def index
        posts = current_user.subscribed_posts
        render json: { posts: posts.as_json }
    end 

    def show
        post = Article.find(params[:id])
        render json: { post: post.as_json }
    end

    def create
        post = Article.find(params[:post_id])
        current_user.subscribed_posts << post unless current_user.subscribed_posts.include?(post)
        render json: { post: post.as_json }
    end

    def destroy
        post = Article.find(params[:post_id])
        current_user.subscribed_posts.delete(post)
        render json: { post: post.as_json }
    end

end
